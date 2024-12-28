# ES - Base - Cluster -  Node.js on AWS ECS

This project demonstrates deploying a simple Node.js application on AWS Elastic Container Service (ECS) using Fargate. The application is containerized with Docker and deployed to AWS infrastructure.

---

## Prerequisites

Before deploying, ensure you have the following:
1. **AWS CLI** installed and configured with appropriate permissions.
2. An **ECS Cluster** created in your AWS account.
3. An **ECR Repository** created for your Docker image.
4. An **IAM Role** with ECS permissions for task execution and service management.

---

## Deployment Steps

### 1. Build and Push the Docker Image
1. Build the Docker image:

bash
   docker build -t hello-world-ecs .
   

2. Tag the Docker image for Amazon ECR:

bash
   docker tag hello-world-ecs:latest <account-id>.dkr.ecr.<region>.amazonaws.com/hello-world-ecs:latest
   

3. Push the image to your ECR repository:

bash
   docker push <account-id>.dkr.ecr.<region>.amazonaws.com/hello-world-ecs:latest
   

---

### 2. Register the Task Definition
1. Replace placeholders in the `task-definition.json` file:
   - `<account-id>`: Your AWS account ID.
   - `<region>`: Your AWS region.
   - `<execution-role-arn>`: ARN of your ECS task execution role.

2. Register the task definition using the AWS CLI:

bash
   aws ecs register-task-definition --cli-input-json file://task-definition.json
   

---

### 3. Create the ECS Service
1. Replace the placeholders with your values in the following command:
   - `<subnet-id>`: Subnet ID where the tasks will run.
   - `<sg-id>`: Security group ID for the tasks.

2. Create the ECS service:

bash
   aws ecs create-service \
       --cluster hello-world-cluster \
       --service-name hello-world-service \
       --task-definition hello-world-task \
       --desired-count 1 \
       --launch-type FARGATE \
       --network-configuration "awsvpcConfiguration={subnets=[<subnet-id>],securityGroups=[<sg-id>],assignPublicIp=ENABLED}"
   

---

### 4. Test the Application
1. List the running tasks:

bash
   aws ecs list-tasks --cluster hello-world-cluster
   

2. Describe the task to retrieve the public IP:

bash
   aws ecs describe-tasks --cluster hello-world-cluster --tasks <task-id>
   

3. Access the application in your browser:


   http://<public-ip>:3000
   

---

### 5. Clean Up Resources
To avoid incurring costs, clean up the resources after testing:
1. Delete the ECS service:

bash
   aws ecs delete-service --cluster hello-world-cluster --service hello-world-service --force
   

2. Delete the ECS cluster:

bash
   aws ecs delete-cluster --cluster hello-world-cluster
   

3. Delete the ECR repository:

bash
   aws ecr delete-repository --repository-name hello-world-ecs --force