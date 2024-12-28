# Deployment Instructions

### Prerequisites
- AWS CLI installed and configured
- ECS cluster created
- ECR repository created
- IAM role with ECS permissions

### Steps
1. **Build and Push Docker Image**
   ```bash
   docker build -t hello-world-ecs .
   docker tag hello-world-ecs:latest <account-id>.dkr.ecr.<region>.amazonaws.com/hello-world-ecs:latest
   docker push <account-id>.dkr.ecr.<region>.amazonaws.com/hello-world-ecs:latest
