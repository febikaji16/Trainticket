# Docker Setup Guide for Train Ticket App

This guide explains how to containerize and deploy your Flutter web application using Docker.

## Prerequisites

- ✅ Docker installed ([Install Docker](https://docs.docker.com/get-docker/))
- ✅ Docker Compose installed (usually comes with Docker Desktop)
- ✅ Basic understanding of Docker commands

## Files Overview

- **Dockerfile** - Multi-stage build for Flutter web app
- **.dockerignore** - Excludes unnecessary files from Docker image
- **docker-compose.yml** - Orchestrates the container deployment

## Quick Start

### 1. Build the Docker Image

```bash
# Build the image
docker build -t trainticket-app .

# Or use docker-compose
docker-compose build
```

### 2. Run the Container

```bash
# Using Docker directly
docker run -d -p 8080:80 --name trainticket trainticket-app

# Or using docker-compose
docker-compose up -d
```

### 3. Access the Application

Open your browser and navigate to:
```
http://localhost:8080
```

## Docker Commands Cheat Sheet

### Building

```bash
# Build image
docker build -t trainticket-app .

# Build without cache
docker build --no-cache -t trainticket-app .

# Build with specific tag
docker build -t trainticket-app:v1.0.0 .
```

### Running

```bash
# Run container
docker run -d -p 8080:80 trainticket-app

# Run with custom name
docker run -d -p 8080:80 --name my-trainticket trainticket-app

# Run with environment variables
docker run -d -p 8080:80 -e NODE_ENV=production trainticket-app
```

### Managing Containers

```bash
# List running containers
docker ps

# List all containers
docker ps -a

# Stop container
docker stop trainticket

# Start container
docker start trainticket

# Restart container
docker restart trainticket

# Remove container
docker rm trainticket

# View logs
docker logs trainticket

# Follow logs in real-time
docker logs -f trainticket
```

### Managing Images

```bash
# List images
docker images

# Remove image
docker rmi trainticket-app

# Remove unused images
docker image prune

# Tag image for registry
docker tag trainticket-app username/trainticket-app:v1.0.0
```

## Docker Compose Commands

```bash
# Start services
docker-compose up

# Start in detached mode
docker-compose up -d

# Stop services
docker-compose down

# View logs
docker-compose logs

# Follow logs
docker-compose logs -f

# Rebuild and restart
docker-compose up -d --build

# Scale services
docker-compose up -d --scale trainticket-web=3
```

## Pushing to Docker Hub

### 1. Create Docker Hub Account

Sign up at [Docker Hub](https://hub.docker.com/)

### 2. Login to Docker Hub

```bash
docker login
# Enter your username and password
```

### 3. Tag Your Image

```bash
# Tag with your Docker Hub username
docker tag trainticket-app yourusername/trainticket-app:latest
docker tag trainticket-app yourusername/trainticket-app:v1.0.0
```

### 4. Push to Docker Hub

```bash
# Push latest
docker push yourusername/trainticket-app:latest

# Push specific version
docker push yourusername/trainticket-app:v1.0.0
```

### 5. Pull from Docker Hub

```bash
# Pull image
docker pull yourusername/trainticket-app:latest

# Run pulled image
docker run -d -p 8080:80 yourusername/trainticket-app:latest
```

## Deployment Options

### Option 1: Local Development

```bash
docker-compose up -d
```

### Option 2: Production Server

```bash
# On your server
git clone https://github.com/febikaji16/Trainticket.git
cd Trainticket
docker-compose up -d
```

### Option 3: Cloud Platforms

#### AWS ECS
1. Push image to Amazon ECR
2. Create ECS task definition
3. Deploy as ECS service

#### Google Cloud Run
```bash
# Build and deploy
gcloud builds submit --tag gcr.io/PROJECT-ID/trainticket-app
gcloud run deploy --image gcr.io/PROJECT-ID/trainticket-app --platform managed
```

#### Azure Container Instances
```bash
# Push to Azure Container Registry
az acr build --registry myregistry --image trainticket-app .

# Deploy
az container create --resource-group myResourceGroup \
  --name trainticket --image myregistry.azurecr.io/trainticket-app:latest
```

#### Heroku
```bash
heroku container:login
heroku container:push web -a your-app-name
heroku container:release web -a your-app-name
```

## Environment Variables

You can pass environment variables to customize the app:

```bash
docker run -d -p 8080:80 \
  -e API_URL=https://api.example.com \
  -e ENV=production \
  trainticket-app
```

Or in `docker-compose.yml`:

```yaml
services:
  trainticket-web:
    environment:
      - API_URL=https://api.example.com
      - ENV=production
```

## Custom Nginx Configuration

Create `nginx.conf` for custom settings:

```nginx
server {
    listen 80;
    server_name localhost;
    
    root /usr/share/nginx/html;
    index index.html;
    
    location / {
        try_files $uri $uri/ /index.html;
    }
    
    # Enable gzip compression
    gzip on;
    gzip_vary on;
    gzip_min_length 10240;
    gzip_types text/plain text/css text/xml text/javascript 
               application/x-javascript application/xml+rss;
}
```

Then uncomment the COPY line in Dockerfile:

```dockerfile
COPY nginx.conf /etc/nginx/conf.d/default.conf
```

## Troubleshooting

### Issue: Container exits immediately

**Solution:** Check logs
```bash
docker logs trainticket
```

### Issue: Port already in use

**Solution:** Use different port
```bash
docker run -d -p 8081:80 trainticket-app
```

### Issue: Build fails

**Solution:** Clean build
```bash
docker system prune -a
docker build --no-cache -t trainticket-app .
```

### Issue: Cannot connect to container

**Solution:** Check container is running
```bash
docker ps
docker inspect trainticket
```

## CI/CD Integration with Jenkins

Add this stage to your Jenkinsfile:

```groovy
stage('Build Docker Image') {
    steps {
        script {
            sh 'docker build -t trainticket-app:${BUILD_NUMBER} .'
            sh 'docker tag trainticket-app:${BUILD_NUMBER} trainticket-app:latest'
        }
    }
}

stage('Push to Registry') {
    steps {
        script {
            withCredentials([usernamePassword(
                credentialsId: 'dockerhub-credentials',
                usernameVariable: 'DOCKER_USER',
                passwordVariable: 'DOCKER_PASS'
            )]) {
                sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                sh 'docker push yourusername/trainticket-app:${BUILD_NUMBER}'
                sh 'docker push yourusername/trainticket-app:latest'
            }
        }
    }
}
```

## Health Checks

Add health check to Dockerfile:

```dockerfile
HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost/ || exit 1
```

## Optimization Tips

1. **Multi-stage builds** - Already implemented to reduce image size
2. **Layer caching** - Order commands from least to most frequently changing
3. **.dockerignore** - Exclude unnecessary files
4. **Specific base images** - Use specific versions instead of `latest`
5. **Combine RUN commands** - Reduce layers

## Security Best Practices

1. Don't run as root user
2. Scan images for vulnerabilities
3. Use official base images
4. Keep base images updated
5. Don't store secrets in images

## Monitoring

Use Docker stats to monitor resource usage:

```bash
# Real-time stats
docker stats trainticket

# One-time stats
docker stats --no-stream trainticket
```

## Resources

- [Docker Documentation](https://docs.docker.com/)
- [Docker Hub](https://hub.docker.com/)
- [Flutter Docker Guide](https://docs.flutter.dev/deployment/web)
- [Nginx Documentation](https://nginx.org/en/docs/)

---

For more help, refer to the project documentation or contact the DevOps team.
