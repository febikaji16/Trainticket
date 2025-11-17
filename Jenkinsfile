pipeline {
    agent any
    
    environment {
        // Flutter installation path (adjust based on your Jenkins setup)
        FLUTTER_HOME = "${WORKSPACE}/flutter"
        PATH = "${FLUTTER_HOME}/bin:${PATH}"
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code from repository...'
                checkout scm
            }
        }
        
        stage('Setup Flutter') {
            steps {
                echo 'Setting up Flutter SDK...'
                script {
                    // Check if Flutter is installed, if not install it
                    sh '''
                        if [ ! -d "$FLUTTER_HOME" ]; then
                            echo "Installing Flutter..."
                            git clone https://github.com/flutter/flutter.git -b stable --depth 1 $FLUTTER_HOME
                        else
                            echo "Flutter already installed, updating..."
                            cd $FLUTTER_HOME
                            git pull
                        fi
                        
                        flutter --version
                        flutter doctor
                    '''
                }
            }
        }
        
        stage('Install Dependencies') {
            steps {
                echo 'Installing Flutter dependencies...'
                sh 'flutter pub get'
            }
        }
        
        stage('Code Analysis') {
            steps {
                echo 'Running Flutter analyze...'
                sh 'flutter analyze'
            }
        }
        
        stage('Run Tests') {
            steps {
                echo 'Running unit tests...'
                sh 'flutter test'
            }
        }
        
        stage('Build Android APK') {
            when {
                branch 'main'
            }
            steps {
                echo 'Building Android APK...'
                sh 'flutter build apk --release'
            }
        }
        
        stage('Build Android App Bundle') {
            when {
                branch 'main'
            }
            steps {
                echo 'Building Android App Bundle...'
                sh 'flutter build appbundle --release'
            }
        }
        
        stage('Archive Artifacts') {
            when {
                branch 'main'
            }
            steps {
                echo 'Archiving build artifacts...'
                archiveArtifacts artifacts: 'build/app/outputs/**/*.apk', fingerprint: true
                archiveArtifacts artifacts: 'build/app/outputs/**/*.aab', fingerprint: true
            }
        }
        
        stage('Deploy to Test Environment') {
            when {
                branch 'develop'
            }
            steps {
                echo 'Deploying to test environment...'
                // Add your deployment script here
                sh 'echo "Deploy to Firebase App Distribution or TestFlight"'
            }
        }
    }
    
    post {
        success {
            echo 'Pipeline completed successfully!'
            // Optional: Send notification (Slack, Email, etc.)
        }
        failure {
            echo 'Pipeline failed!'
            // Optional: Send failure notification
        }
        always {
            echo 'Cleaning up workspace...'
            cleanWs()
        }
    }
}
