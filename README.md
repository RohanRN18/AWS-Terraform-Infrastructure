# Project Objective

The **AWS Infrastructure Project using Terraform** is designed to provision a basic cloud infrastructure that includes VPC, subnets, EC2 instance, security groups, and networking. This setup demonstrates foundational cloud architecture, automates infrastructure deployment, and ensures accessibility of a web server using EC2 User Data. The goal is to showcase a working AWS environment deployed entirely with Terraform while following best practices for modularity and security.

---

📌 **Project Description**

**Objective**

- Deploy a functional AWS VPC with public and private subnets.
- Launch an EC2 instance in the public subnet with automated setup using User Data.
- Ensure secure access through Security Groups (SSH and HTTP).
- Demonstrate infrastructure as code principles using Terraform.

**Setup Components**

- **VPC**: Single VPC with CIDR `10.0.0.0/16`.
- **Subnets**: 1 Public Subnet + 2 Private Subnets in different Availability Zones.
- **Internet Gateway**: For public subnet internet access.
- **Route Table**: Routes traffic from public subnet to Internet Gateway.
- **EC2 Instance**: Linux instance with public IP, configured with User Data (Nginx web server).
- **Security Group**: Allows SSH (port 22) and HTTP (port 80) access.
- **Terraform State Management**: Optional S3 backend for remote state storage.
- **Automation**: User Data script to automatically configure web server on instance launch.

**Workflow**

- Terraform scripts (`main.tf`, `variables.tf`, `outputs.tf`, `backend.tf`) define all resources.
- Apply Terraform to provision infrastructure automatically.
- EC2 User Data runs at launch, installing and starting Nginx.
- Access the EC2 public IP to verify web server availability.

---


📌 **Architecture Flow**

- **VPC (Virtual Private Cloud)**: Contains all subnets and networking resources.
- **Public Subnet**: Hosts EC2 instance with internet access via Internet Gateway.
- **Private Subnets**: Can host internal resources (not exposed to internet).
- **Internet Gateway**: Enables traffic to/from the internet for public subnet.
- **Route Table**: Directs public subnet traffic to IGW.
- **EC2 Instance**: Serves as a web server, configured using User Data.
- **Security Groups**: Control inbound and outbound access (SSH + HTTP).

