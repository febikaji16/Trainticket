# Kubernetes Deployment Guide for Train Ticket App

This guide shows how to deploy your Train Ticket app to Kubernetes.

## Prerequisites

- Docker Desktop with Kubernetes enabled
- kubectl CLI installed
- Docker image on Docker Hub: `febikaji16/trainticket-app:latest`

## Enable Kubernetes in Docker Desktop

1. Open Docker Desktop
2. Settings → Kubernetes
3. ✅ Enable Kubernetes
4. Apply & Restart

## Deployment Files

### `k8s/deployment.yaml`
- **Deployment**: Runs 3 replicas of your app
- **Service**: LoadBalancer exposing port 80 → 30000
- **Health checks**: Monitors app health

### `k8s/autoscaling.yaml`
- Auto-scales from 2-10 pods based on CPU/memory usage

## Deploy to Kubernetes

### 1. Deploy the application:

```bash
# Apply deployment and service
kubectl apply -f k8s/deployment.yaml

# Verify deployment
kubectl get deployments
kubectl get pods
kubectl get services
```

### 2. Enable autoscaling (optional):

```bash
kubectl apply -f k8s/autoscaling.yaml
kubectl get hpa
```

### 3. Access your app:

```bash
# Get the service URL
kubectl get service trainticket-service

# Access the app
open http://localhost:30000
```

## Kubernetes Commands

### View Resources

```bash
# List all pods
kubectl get pods

# List services
kubectl get services

# List deployments
kubectl get deployments

# View pod logs
kubectl logs <pod-name>

# Describe pod (troubleshooting)
kubectl describe pod <pod-name>
```

### Scale Manually

```bash
# Scale to 5 replicas
kubectl scale deployment trainticket-app --replicas=5

# Verify
kubectl get pods
```

### Update Application

```bash
# After pushing new image to Docker Hub
kubectl set image deployment/trainticket-app trainticket-app=febikaji16/trainticket-app:v2

# Or update with latest
kubectl rollout restart deployment/trainticket-app
```

### Monitor Rollout

```bash
# Watch rollout status
kubectl rollout status deployment/trainticket-app

# View rollout history
kubectl rollout history deployment/trainticket-app

# Rollback to previous version
kubectl rollout undo deployment/trainticket-app
```

### Delete Resources

```bash
# Delete deployment and service
kubectl delete -f k8s/deployment.yaml

# Delete autoscaling
kubectl delete -f k8s/autoscaling.yaml

# Delete everything
kubectl delete all --all
```

## Architecture

```
┌─────────────────────────────────────┐
│         LoadBalancer Service         │
│         (localhost:30000)            │
└──────────────┬──────────────────────┘
               │
       ┌───────┴────────┬──────────┐
       │                │          │
   ┌───▼────┐      ┌───▼────┐  ┌──▼─────┐
   │ Pod 1  │      │ Pod 2  │  │ Pod 3  │
   │ App:80 │      │ App:80 │  │ App:80 │
   └────────┘      └────────┘  └────────┘
```

## Features Enabled

✅ **High Availability**: 3 replicas running  
✅ **Auto-scaling**: 2-10 pods based on load  
✅ **Health Checks**: Auto-restart unhealthy pods  
✅ **Load Balancing**: Traffic distributed across pods  
✅ **Rolling Updates**: Zero-downtime deployments  
✅ **Self-Healing**: Automatic pod replacement  

## Troubleshooting

### Pods not starting?

```bash
kubectl describe pod <pod-name>
kubectl logs <pod-name>
```

### Service not accessible?

```bash
# Check service
kubectl get svc trainticket-service

# Check if Kubernetes is running
kubectl cluster-info
```

### Image pull errors?

```bash
# Make sure image is on Docker Hub
docker pull febikaji16/trainticket-app:latest
```

## Comparison: Docker vs Kubernetes

### Current Docker Setup:
```bash
docker run -d -p 3000:80 trainticket-app
# 1 container, manual scaling, manual recovery
```

### With Kubernetes:
```bash
kubectl apply -f k8s/
# 3+ containers, auto-scaling, auto-recovery
```

## Next Steps

1. Deploy to cloud Kubernetes (EKS, GKE, AKS)
2. Add CI/CD with Jenkins → Kubernetes
3. Set up monitoring (Prometheus, Grafana)
4. Add database with persistent volumes

---

For production deployment to cloud, see cloud-specific guides for:
- **AWS EKS** (Elastic Kubernetes Service)
- **Google GKE** (Google Kubernetes Engine)
- **Azure AKS** (Azure Kubernetes Service)
