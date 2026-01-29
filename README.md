# AWS ECS Fargate Enterprise App — Production Deployment (Terraform + GitHub Actions + FastAPI)

This project demonstrates a production-ready deployment pipeline using:

- AWS ECS Fargate for serverless container hosting  
- AWS Application Load Balancer (ALB) for traffic routing  
- AWS ECR for container image storage  
- Terraform for Infrastructure-as-Code  
- GitHub Actions (OIDC) for secure CI/CD  
- FastAPI as the backend application  

It is designed to be educational, reproducible, and portfolio-ready, showing how modern DevOps teams deploy applications without storing AWS credentials.

---

## Project Overview

This repository contains:

- A FastAPI application (`app/`)
- Terraform configuration for provisioning AWS infrastructure (`infra/terraform/`)
- A GitHub Actions workflow for CI/CD (`.github/workflows/`)
- A production-ready ECS Fargate service behind an ALB
- A secure OIDC-based deployment pipeline

The goal is to demonstrate a real-world cloud deployment workflow that mirrors what companies use in production.

---

## Architecture Summary

**FastAPI Application**  
A lightweight Python API served using Uvicorn.  
Containerized using a Dockerfile and deployed to AWS.

**AWS ECR**  
Stores the Docker images built by GitHub Actions.

**AWS ECS Fargate**  
Runs the container in a serverless environment.  
No EC2 instances required.

**Application Load Balancer**  
Routes HTTP traffic to the ECS service.  
Performs health checks on the container.

**Terraform**  
Manages all AWS resources:

- VPC, subnets, security groups  
- ECS cluster and service  
- Task definitions  
- ALB and target groups  
- IAM roles  
- ECR repository  

**GitHub Actions (OIDC)**  
Builds and pushes Docker images to ECR.  
Deploys new task definitions to ECS.  
Uses AWS OIDC for secure, keyless authentication.

---

## Repository Structure
aws-ecs-fargate-enterprise-app/
├── app/
│   ├── main.py
│   └── requirements.txt
│
├── infra/
│   └── terraform/
│       ├── backend.tf
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── ...
│
├── .github/
│   └── workflows/
│       └── deploy.yml
│
├── Dockerfile
├── README.md
└── .gitignore
---

## Terraform Backend Configuration

This project uses an S3 backend for storing Terraform state.

For security reasons, the S3 bucket name is not included in this repository.

Your `backend.tf` should look like this:

```hcl
terraform {
  backend "s3" {
    # Replace the values below with your own S3 bucket details.
    # Example:
    # bucket = "my-terraform-state-bucket"
    # key    = "enterprise-app/terraform.tfstate"
    # region = "eu-west-2"

    bucket = "<your-s3-bucket-name>"
    key    = "enterprise-app/terraform.tfstate"
    region = "<your-aws-region>"
  }
}


Deploying the Infrastructure

Create an S3 bucket
Update backend.tf with your bucket name and region

Run:
terraform init
terraform apply

CI/CD Pipeline (GitHub Actions)
The pipeline performs:
Build
Installs dependencies
Builds the Docker image
Tags it with latest
Authenticate to AWS using OIDC
No AWS keys stored in GitHub.
GitHub requests temporary credentials from AWS.
Push to ECR
The built image is uploaded to your ECR repository.
Deploy to ECS
Updates the task definition
Triggers a new deployment
ECS pulls the new image
ALB health checks ensure zero downtime
This mirrors real enterprise deployment workflows.

Application Endpoints
Once deployed, the ALB exposes:
/ — root endpoint
/health — health check endpoint
Any additional FastAPI routes you add

Local Development
Run the app locally:

uvicorn app.main:app --reload
Build the Docker image locally:
docker build -t enterprise-app .
docker run -p 8000:8000 enterprise-app

Cost Awareness and Teardown
AWS resources incur cost.
To avoid charges, destroy the infrastructure when finished:

terraform destroy

This removes:
ECS cluster
ALB
ECR repository
IAM roles
VPC resources
You may also manually delete:
CloudWatch logs
ECR images
S3 bucket (after emptying it)


What This Project Demonstrates

This project shows understanding of:
Infrastructure-as-Code (Terraform)
Secure CI/CD with GitHub OIDC
Containerization and Docker best practices
AWS ECS Fargate production deployments
Load balancing and health checks
Clean Git workflows and repo hygiene
Real-world DevOps architecture patterns
It is a strong portfolio piece for:
DevOps Engineer
Cloud Engineer
Platform Engineer
SRE roles


Future Enhancements
Potential improvements:
Add autoscaling policies
Add HTTPS with ACM and Route53
Add staging environment
Add CloudWatch dashboards
Add RDS or DynamoDB backend


Final Notes
This project is intentionally designed to be:
Educational
Reproducible
Secure
Clean
Easy for reviewers to understand
It reflects real-world DevOps workflows and demonstrates hands-on cloud engineering capability.
