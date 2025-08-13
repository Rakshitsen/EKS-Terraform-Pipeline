-----

## title: "EKS Infrastructure with Terraform, Jenkins, and GitHub Actions"

# EKS Infrastructure with Terraform, Jenkins, and GitHub Actions

## 📌 Overview

This project provisions an **Amazon EKS Cluster** along with the necessary **VPC infrastructure** using **Terraform**. It includes a **Jenkins pipeline** with parameterized execution for flexible deployment and destruction of infrastructure, as well as a **GitHub Actions workflow** for automated Terraform validation and deployment.

The setup uses **S3 as the Terraform backend** with **DynamoDB for state locking** to enable consistent, safe, and collaborative infrastructure management.

-----

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
```

-----

## ⚙️ Tools & Technologies

  - **AWS** (VPC, EKS, IAM, S3, DynamoDB)
  - **Terraform** (Infrastructure as Code)
  - **Jenkins** (CI/CD Pipeline)
  - **GitHub Actions** (Automation & Validation)
  - **S3** (Remote Terraform state)
  - **DynamoDB** (State file locking)

-----

## 🚀 Features

  - **Modular Terraform structure** (modules/vpc & modules/eks)
  - **Jenkins pipeline** with parameterized control:
      - `Re_init`: Re-run `terraform init` if providers/modules change
      - `Create`: Provision infrastructure
      - `Destroy`: Tear down infrastructure
  - **GitHub Actions workflow** for Terraform validation and/or deployment
  - **Remote state management** with S3 backend and DynamoDB locking
  - **Idempotent Terraform runs** (no duplicate infra creation)

-----

## 📋 Prerequisites

  - An AWS account with the required permissions
  - An S3 bucket for Terraform state
  - A DynamoDB table for state locking
  - Terraform installed (v1.x or later)
  - A Jenkins server with:
      - AWS CLI configured
      - Terraform installed
      - Credentials set in the Jenkins credentials store

-----

## 🔧 Setup & Configuration

### 1️⃣ Clone the repository

```bash
git clone https://github.com/<your-username>/<your-repo>.git
cd <your-repo>
```

### 2️⃣ Configure `terraform.tf` (Backend)

Update the `terraform.tf` file with your S3 bucket and DynamoDB table details.

**Example:**

```terraform
terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "eks/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
```

### 3️⃣ Update `terraform.tfvars`

Modify the `terraform.tfvars` file to specify your desired cluster settings.

**Example:**

```terraform
region       = "ap-south-1"
cluster_name = "my-eks-cluster"
node_count   = 2
node_type    = "t3.medium"
```

-----

## 🏗️ Running via Jenkins

The Jenkins pipeline supports three parameters:

  - `Re_init` → **Boolean** (Run `terraform init`)
  - `Create` → **Boolean** (Run `terraform apply`)
  - `Destroy` → **Boolean** (Run `terraform destroy`)

**Example flow:**

  - To create the infrastructure, run the pipeline with `Re_init = true` and `Create = true`.
  - To delete the infrastructure, run the pipeline with only `Destroy = true`.

-----

## 🤖 Running via GitHub Actions

The provided GitHub Actions workflow validates your Terraform code on every push to the `main` branch. You can extend this workflow to automatically deploy your infrastructure as well.

**Example workflow (`.github/workflows/deploy.yml`):**

```yaml
name: Terraform Deploy
on:
  push:
    branches:
      - main
jobs:
  terraform:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: hashicorp/setup-terraform@v3
        with:
          terraform_version: 1.6.0
      - run: terraform init
      - run: terraform plan
```

-----

## 📤 Outputs

After successful creation, Terraform will output the following details:

  - EKS Cluster Name
  - Cluster Endpoint
  - VPC ID
  - Node Group Details

-----

## 🛠️ Troubleshooting

  - **"Nothing to delete" in destroy**: Ensure you are using the correct S3 backend state.
  - **Pipeline tries to recreate infra**: Check if your local state is out of sync; the remote state should fix this.
  - **State lock error**: Check the DynamoDB table for any stuck locks.

-----

🔒 Terraform State File Locking (Demo)

This project uses DynamoDB for Terraform state locking to ensure that only one process can modify the infrastructure at a time.
If two Terraform operations run simultaneously (e.g., one from Jenkins and one from GitHub Actions), one will fail with a lock error until the other finishes.

![alt text](<Screenshot from 2025-08-13 11-01-15.png>)

Example Lock Error (From Jenkins)
Error message: operation error DynamoDB: PutItem, https response error
StatusCode: 400, RequestID: <request-id>, ConditionalCheckFailedException: The conditional request failed

Terraform acquires a state lock to protect the state from being written by multiple users at the same time.
Please resolve the issue above and try again.

![alt text](<Screenshot from 2025-08-13 11-01-59.png>)
## 📜 License

This project is licensed under the MIT License.

-----

## ✨ Author

Rakshit Sen  
Cloud & DevOps Enthusiast  
📧 rakshitsen1@gmail.com  
