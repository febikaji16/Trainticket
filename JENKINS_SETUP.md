# Jenkins CI/CD Setup Guide for Train Ticket App

This guide will help you set up Jenkins to automatically build, test, and deploy your Flutter application.

## Prerequisites

Before setting up Jenkins, ensure you have:

- ✅ Jenkins server installed and running
- ✅ Git installed on Jenkins server
- ✅ GitHub repository with your code
- ✅ Jenkins plugins installed:
  - Git plugin
  - Pipeline plugin
  - GitHub plugin (optional, for webhooks)

## Step 1: Push Your Code to GitHub

If you haven't already pushed your code:

```bash
# Check current git status
git status

# Add all changes
git add .

# Commit your changes
git commit -m "Add Jenkins pipeline configuration"

# Push to develop branch
git push origin develop

# Or push to main branch
git push origin main
```

## Step 2: Configure Jenkins Server

### Install Required Plugins

1. Go to Jenkins Dashboard
2. Click **Manage Jenkins** → **Manage Plugins**
3. Install these plugins:
   - Git Plugin
   - Pipeline Plugin
   - GitHub Integration Plugin (for webhooks)
   - Slack Notification Plugin (optional)

### Configure Git in Jenkins

1. Go to **Manage Jenkins** → **Global Tool Configuration**
2. Under **Git**, ensure Git is configured
3. Save the configuration

## Step 3: Create Jenkins Pipeline Job

### Option A: Pipeline from SCM (Recommended)

1. **Create New Job**
   - Click **New Item** on Jenkins Dashboard
   - Enter job name: `TrainTicket-Pipeline`
   - Select **Pipeline**
   - Click **OK**

2. **Configure Source Code Management**
   - Under **Pipeline** section
   - Select **Pipeline script from SCM**
   - SCM: **Git**
   - Repository URL: `https://github.com/febikaji16/Trainticket.git`
   - Credentials: Add your GitHub credentials if private repo
   - Branch Specifier: `*/develop` (or `*/main`)
   - Script Path: `Jenkinsfile`

3. **Configure Build Triggers** (Optional)
   - ☑️ **GitHub hook trigger for GITScm polling** (for automatic builds on push)
   - Or ☑️ **Poll SCM** with schedule: `H/5 * * * *` (every 5 minutes)

4. **Save** the configuration

### Option B: Multibranch Pipeline (Advanced)

For automatic pipeline creation per branch:

1. Create **New Item** → **Multibranch Pipeline**
2. Name: `TrainTicket-App`
3. Add **Branch Source** → **Git**
   - Repository URL: `https://github.com/febikaji16/Trainticket.git`
   - Add credentials if needed
4. **Build Configuration**
   - Mode: **by Jenkinsfile**
   - Script Path: `Jenkinsfile`
5. **Scan Multibranch Pipeline Triggers**
   - ☑️ Periodically if not otherwise run
   - Interval: 1 hour
6. **Save**

## Step 4: Set Up GitHub Webhook (Optional)

For automatic builds when you push code:

### On GitHub:

1. Go to your repository: `https://github.com/febikaji16/Trainticket`
2. Click **Settings** → **Webhooks** → **Add webhook**
3. Payload URL: `http://YOUR_JENKINS_URL/github-webhook/`
   - Example: `http://jenkins.yourcompany.com/github-webhook/`
4. Content type: `application/json`
5. Which events: **Just the push event**
6. ☑️ Active
7. Click **Add webhook**

### On Jenkins:

1. Go to your pipeline job → **Configure**
2. Under **Build Triggers**
3. ☑️ **GitHub hook trigger for GITScm polling**
4. **Save**

## Step 5: Configure Environment Variables

If you need to set up secrets (API keys, signing keys):

1. Go to **Manage Jenkins** → **Manage Credentials**
2. Click on **(global)** domain
3. Click **Add Credentials**
4. Add your secrets:
   - API keys
   - Signing keystores
   - Firebase credentials (for deployment)

Then reference them in your Jenkinsfile:
```groovy
environment {
    API_KEY = credentials('api-key-id')
}
```

## Step 6: Run Your First Build

1. Go to your Jenkins pipeline job
2. Click **Build Now**
3. Monitor the build in **Console Output**

## Pipeline Stages Explained

Your Jenkinsfile includes these stages:

1. **Checkout** - Pulls code from Git repository
2. **Setup Flutter** - Installs/updates Flutter SDK
3. **Install Dependencies** - Runs `flutter pub get`
4. **Code Analysis** - Runs `flutter analyze` for code quality
5. **Run Tests** - Executes unit tests
6. **Build Android APK** - Builds release APK (main branch only)
7. **Build Android App Bundle** - Builds AAB for Play Store (main branch only)
8. **Archive Artifacts** - Saves build outputs
9. **Deploy** - Deploys to test environment (develop branch)

## Customizing the Pipeline

### For iOS Builds

Add this stage to your Jenkinsfile:

```groovy
stage('Build iOS') {
    when {
        branch 'main'
    }
    agent {
        label 'macos' // Requires macOS agent
    }
    steps {
        echo 'Building iOS app...'
        sh 'flutter build ios --release --no-codesign'
    }
}
```

### For Web Builds

Add this stage:

```groovy
stage('Build Web') {
    steps {
        echo 'Building web app...'
        sh 'flutter build web --release'
    }
}
```

### Deploy to Firebase App Distribution

```groovy
stage('Deploy to Firebase') {
    steps {
        sh '''
            firebase appdistribution:distribute \
                build/app/outputs/flutter-apk/app-release.apk \
                --app YOUR_FIREBASE_APP_ID \
                --token YOUR_FIREBASE_TOKEN \
                --groups testers
        '''
    }
}
```

## Troubleshooting

### Issue: Flutter command not found

**Solution:** Ensure Flutter is in PATH or use absolute path:
```groovy
sh '/path/to/flutter/bin/flutter pub get'
```

### Issue: Permission denied on Android build

**Solution:** Add executable permissions:
```groovy
sh 'chmod +x android/gradlew'
```

### Issue: Out of memory during build

**Solution:** Increase Java heap size in Jenkinsfile:
```groovy
environment {
    GRADLE_OPTS = '-Xmx2048m'
}
```

## Monitoring and Notifications

### Email Notifications

Add to your Jenkinsfile `post` section:
```groovy
post {
    success {
        emailext (
            subject: "Build Successful: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
            body: "The build was successful!",
            to: "your-email@example.com"
        )
    }
    failure {
        emailext (
            subject: "Build Failed: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
            body: "The build failed. Check console output.",
            to: "your-email@example.com"
        )
    }
}
```

### Slack Notifications

```groovy
post {
    success {
        slackSend (
            color: 'good',
            message: "Build Successful: ${env.JOB_NAME} #${env.BUILD_NUMBER}"
        )
    }
}
```

## Next Steps

1. ✅ Push your code to GitHub
2. ✅ Create Jenkins pipeline job
3. ✅ Configure GitHub webhook (optional)
4. ✅ Run your first build
5. ✅ Set up deployment to test/production environments
6. ✅ Configure notifications

## Useful Jenkins Commands

```bash
# Start Jenkins (Linux)
sudo systemctl start jenkins

# Check Jenkins status
sudo systemctl status jenkins

# View Jenkins logs
sudo journalctl -u jenkins -f

# Restart Jenkins
sudo systemctl restart jenkins
```

## Resources

- [Jenkins Documentation](https://www.jenkins.io/doc/)
- [Flutter CI/CD Best Practices](https://docs.flutter.dev/deployment/cd)
- [Jenkins Pipeline Syntax](https://www.jenkins.io/doc/book/pipeline/syntax/)

---

For more help, refer to the project documentation or contact the DevOps team.
