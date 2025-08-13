# EKS Infrastructure with Terraform, Jenkins, and GitHub Actions

## 📌 Overview
This project provisions an **Amazon EKS Cluster** along with the necessary **VPC infrastructure** using **Terraform**.  
It includes a **Jenkins pipeline** with parameterized execution for flexible deployment and destruction of infrastructure,  
as well as a **GitHub Actions workflow** for automated Terraform validation and deployment.

The setup uses **S3 as the Terraform backend** with **DynamoDB for state locking** to enable consistent, safe, and collaborative infrastructure management.

---

## 📂 Project Structure

```plaintext
.
├── .github/workflows       # GitHub Actions workflows
├── modules
│   ├── vpc                 # VPC module
│   └── eks                 # EKS module
├── .gitignore              # Ignored files/folders
├── .terraform.lock.hcl     # Provider version lock file
├── Jenkinsfile             # Jenkins pipeline definition
├── main.tf                 # Root Terraform configuration
├── output.tf               # Output definitions
├── terraform.tf            # Backend and provider configuration
├── terraform.tfvars        # Variable values
├── variables.tf            # Variable definitions