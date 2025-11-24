# Jenkins + Docker Integration Guide

This guide explains how to integrate Docker with Jenkins for automated Docker image builds and deployments.

## Prerequisites

- ✅ Jenkins server installed and running
- ✅ Docker installed on Jenkins server
- ✅ Docker Hub account (or private registry)
- ✅ Jenkins has permissions to run Docker commands

## Step 1: Install Docker on Jenkins Server

### macOS (if Jenkins is running locally)
Docker Desktop is already installed.

### Linux (Ubuntu/Debian)
```bash
# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Add Jenkins user to docker group
sudo usermod -aG docker jenkins

# Restart Jenkins
sudo systemctl restart jenkins
```

## Step 2: Install Docker Pipeline Plugin in Jenkins

1. Go to **Jenkins Dashboard**
2. Click **Manage Jenkins** → **Manage Plugins**
3. Go to **Available** tab
4. Search for "Docker Pipeline"
5. Install the following plugins:
   - **Docker Pipeline**
   - **Docker plugin**
   - **CloudBees Docker Build and Publish**
6. Restart Jenkins

## Step 3: Add Docker Hub Credentials to Jenkins

### Create Docker Hub Access Token

1. Log in to [Docker Hub](https://hub.docker.com/)
2. Go to **Account Settings** → **Security**
3. Click **New Access Token**
4. Name: `jenkins-token`
5. Copy the token

### Add Credentials in Jenkins

1. Go to **Manage Jenkins** → **Manage Credentials**
2. Click on **(global)** domain
3. Click **Add Credentials**
4. Fill in:
   - **Kind**: Username with password
   - **Scope**: Global
   - **Username**: Your Docker Hub username
   - **Password**: Your Docker Hub access token
   - **ID**: `dockerhub-credentials`
   - **Description**: Docker Hub Credentials
5. Click **OK**

## Step 4: Update Jenkinsfile Environment Variables

The Jenkinsfile has been updated with Docker integration. Update these values:

```groovy
environment {
    DOCKER_IMAGE = "yourusername/trainticket-app"  // Change to your Docker Hub username
    DOCKER_REGISTRY = "docker.io"
    DOCKER_CREDENTIALS_ID = "dockerhub-credentials"
}
```

## Step 5: Verify Docker Access in Jenkins

Create a test job to verify Docker works:

1. **New Item** → **Pipeline**
2. Name: `Docker-Test`
3. Pipeline script:

```groovy
pipeline {
    agent any
    stages {
        stage('Test Docker') {
            steps {
                sh 'docker --version'
                sh 'docker ps'
                sh 'docker images'
            }
        }
    }
}
```

4. **Save** and **Build Now**
5. Check Console Output for Docker version

## Step 6: Push Your Updated Code

```bash
# Add the updated Jenkinsfile
git add Jenkinsfile

# Commit changes
git commit -m "Add Docker integration to Jenkins pipeline"

# Push to repository
git push origin develop
```

## Step 7: Run Your Pipeline

1. Go to your **TrainTicket-Pipeline** job
2. Click **Build Now**
3. Watch the pipeline execute these new stages:
   - Build Docker Image
   - Push to Docker Registry
   - Deploy Docker Container (on develop branch)

## Pipeline Workflow

### On `develop` branch:
1. ✅ Checkout code
2. ✅ Setup Flutter
3. ✅ Install dependencies
4. ✅ Code analysis
5. ✅ Run tests
6. ✅ **Build Docker image**
7. ✅ **Push to Docker Hub**
8. ✅ **Deploy container to test environment**

### On `main` branch:
1. ✅ All of the above
2. ✅ Build Android APK/AAB
3. ✅ Archive artifacts
4. ✅ **Build Docker image with `production` tag**
5. ✅ **Push to Docker Hub**

## Docker Image Tags

Your pipeline creates multiple tags:

- `trainticket-app:BUILD_NUMBER` - Specific build version
- `trainticket-app:latest` - Latest build
- `trainticket-app:develop` - Latest from develop branch
- `trainticket-app:production` - Latest from main branch

## Accessing Docker Images

### Pull from Docker Hub

```bash
# Pull latest
docker pull yourusername/trainticket-app:latest

# Pull specific build
docker pull yourusername/trainticket-app:42

# Pull production
docker pull yourusername/trainticket-app:production
```

### Run Pulled Image

```bash
docker run -d -p 8080:80 --name trainticket yourusername/trainticket-app:latest
```

## Deploy to Production Server

### Option 1: SSH Deployment

Add this stage to Jenkinsfile:

```groovy
stage('Deploy to Production') {
    when {
        branch 'main'
    }
    steps {
        script {
            sshagent(credentials: ['production-server-ssh']) {
                sh """
                    ssh user@production-server '
                        docker pull ${DOCKER_IMAGE}:production
                        docker stop trainticket-prod || true
                        docker rm trainticket-prod || true
                        docker run -d -p 80:80 --name trainticket-prod ${DOCKER_IMAGE}:production
                    '
                """
            }
        }
    }
}
```

### Option 2: Kubernetes Deployment

```groovy
stage('Deploy to Kubernetes') {
    steps {
        script {
            sh """
                kubectl set image deployment/trainticket trainticket=${DOCKER_IMAGE}:${BUILD_NUMBER}
                kubectl rollout status deployment/trainticket
            """
        }
    }
}
```

### Option 3: Docker Swarm

```groovy
stage('Deploy to Docker Swarm') {
    steps {
        sh """
            docker service update --image ${DOCKER_IMAGE}:${BUILD_NUMBER} trainticket
        """
    }
}
```

## Advanced: Multi-Architecture Builds

Build for both ARM and AMD architectures:

```groovy
stage('Build Multi-Arch Docker Image') {
    steps {
        sh """
            docker buildx create --use
            docker buildx build --platform linux/amd64,linux/arm64 \\
                -t ${DOCKER_IMAGE}:${BUILD_NUMBER} \\
                -t ${DOCKER_IMAGE}:latest \\
                --push .
        """
    }
}
```

## Monitoring Docker Containers

### View Running Containers

```bash
# On Jenkins server
docker ps

# View logs
docker logs trainticket-app-test

# Check resource usage
docker stats trainticket-app-test
```

### Jenkins Console Output

The pipeline will show:
- Image build progress
- Push progress to registry
- Container deployment status

## Troubleshooting

### Issue: Permission denied while accessing Docker socket

**Solution:**
```bash
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins
```

### Issue: Docker command not found in Jenkins

**Solution:**
Ensure Docker is in PATH for Jenkins user:
```bash
sudo visudo
# Add this line:
jenkins ALL=(ALL) NOPASSWD: /usr/bin/docker
```

### Issue: Failed to push image to registry

**Solution:**
1. Verify Docker Hub credentials in Jenkins
2. Check credential ID matches Jenkinsfile
3. Ensure Docker Hub token has write permissions

### Issue: Container port already in use

**Solution:**
```groovy
sh """
    docker stop \$(docker ps -q --filter "publish=8080") || true
    docker run -d -p 8080:80 --name trainticket trainticket-app
"""
```

## Security Best Practices

1. **Use Docker secrets** for sensitive data
2. **Scan images** for vulnerabilities:
   ```groovy
   stage('Security Scan') {
       steps {
           sh 'docker scan ${DOCKER_IMAGE}:${BUILD_NUMBER}'
       }
   }
   ```

3. **Use specific base image versions** in Dockerfile
4. **Limit container resources**:
   ```bash
   docker run -d -p 8080:80 --memory="512m" --cpus="1.0" trainticket-app
   ```

5. **Run as non-root user** in Dockerfile

## Clean Up Old Images

The pipeline automatically cleans images older than 24 hours. Manual cleanup:

```bash
# Remove unused images
docker image prune -a -f

# Remove images older than 7 days
docker image prune -a -f --filter "until=168h"

# Remove all stopped containers
docker container prune -f
```

## Environment-Specific Configurations

### Development
```bash
docker run -d -p 3000:80 -e ENV=development trainticket-app:develop
```

### Staging
```bash
docker run -d -p 8080:80 -e ENV=staging trainticket-app:latest
```

### Production
```bash
docker run -d -p 80:80 -e ENV=production --restart always trainticket-app:production
```

## Next Steps

1. ✅ Add Docker Hub credentials to Jenkins
2. ✅ Update DOCKER_IMAGE in Jenkinsfile with your username
3. ✅ Push updated Jenkinsfile to repository
4. ✅ Run Jenkins build
5. ✅ Verify image appears in Docker Hub
6. ✅ Set up production deployment

## Resources

- [Docker Pipeline Plugin](https://plugins.jenkins.io/docker-workflow/)
- [Docker Hub](https://hub.docker.com/)
- [Jenkins Docker Documentation](https://www.jenkins.io/doc/book/pipeline/docker/)
- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)

---

Your Jenkins pipeline now automatically builds, tests, and deploys Docker containers! 🚀
