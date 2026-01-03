🚀 terraform-3tier-ci-cd
📌 Overview

This project demonstrates a production-grade 3-tier AWS infrastructure designed and implemented using Terraform and GitHub Actions CI/CD.

The focus of this project is safe, secure, and controlled infrastructure delivery, following real-world DevOps practices such as environment isolation, approval-based deployments, remote state management, and OIDC-based authentication.



🧠 Project Goals

Build a highly available and scalable 3-tier architecture
Use Infrastructure as Code (IaC) with Terraform
Implement production-style CI/CD pipelines
Enforce deployment safety and security
Support multiple environments (dev / stg / prod) using the same codebase



🏗️ Architecture Overview
3-Tier Design

Presentation Layer
Application Load Balancer (ALB)
Public Subnets (Multi-AZ)

Application Layer
EC2 instances managed by Auto Scaling Group
Private Subnets
NGINX serving web content

Data Layer
Database deployed in private DB subnets
Access restricted via Security Groups

Key Architecture Features:
Multi-AZ deployment for high availability
Auto Scaling for fault tolerance and scalability
Strict network isolation using public/private subnets
Security Groups controlling access between layers




🌍 Multi-Environment Strategy

The project supports three isolated environments:
dev – development & testing
stg – validation before production
prod – live production environment
Each environment:
Uses the same Terraform codebase
Is isolated using Terraform workspaces
Has environment-specific configurations
Is deployed via controlled CI/CD workflows




🔁 CI/CD Pipeline (GitHub Actions)
✅ CI – Terraform Plan

Triggered on Pull Requests.

Steps:
Terraform init
Terraform validate
Terraform plan

Matrix strategy for:
dev
stg
prod

Plan files stored as artifacts:
tfplan-dev
tfplan-stg
tfplan-prod

👉 No infrastructure changes are applied during CI.



🚀 CD – Terraform Apply

Triggered via:
workflow_dispatch
After PR merge

Steps1-way:
Download approved plan artifact
Select environment workspace
Apply only the reviewed plan
Manual approval required for:
staging
production

Steps2-way:
checkout repository
Select environment workspace
Plan 
Apply 
Manual approval required for:
staging
production

👉 Ensures safe and auditable deployments.


🔐 Security Practices
GitHub Actions uses AWS OIDC
No long-lived AWS access keys stored
Temporary credentials via IAM Role assumption
GitHub Environment protection rules
Manual approvals for higher environments



📦 Terraform State Management
Remote backend using Amazon S3
State locking via DynamoDB
Prevents concurrent state corruption
Enables safe team collaboration



⚙️ Application Configuration
NGINX installed via EC2 user-data
Environment-based dynamic content
Same AMI reused across environments
Environment value passed from Terraform


Example output:
DEV → green background
STG → yellow background
PROD → red background



⭐ What Makes This Project Production-Grade

High availability (Multi-AZ)
Auto Scaling & fault recovery
Network isolation & security
Environment-based validation
Plan-before-apply CI/CD strategy
Artifact-based deployments
Manual approval gates
OIDC-based authentication
Remote & locked Terraform state



🛠️ Tech Stack:-
Terraform
AWS (VPC, EC2, ALB, ASG, IAM, S3, DynamoDB)
GitHub Actions
NGINX
Linux (Ubuntu / Amazon Linux)



👤 Author
Designed and implemented by Sunil Chouhan
This project was built to understand and practice real production-grade DevOps workflows, not just infrastructure automation.



🔮 Future Improvements:-
Monitoring & alerts (CloudWatch)
Drift detection pipeline
Cost optimization policies
Blue/Green deployments
Kubernetes-based extension




📌 Final Note
This project prioritizes safety, control, and reliability over speed, following how real production infrastructure is managed.
