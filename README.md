This repon contain the Azure Policy definitions and assignments used for Azure Spring Clean 2025

![Azure Spring Clean](/images/Enforcing%20Compliance%20with%20Azure%20Policy%20in%20Azure%20Pipelines.jpg)

📖 Overview

This repo contains a high-level diagram of the setup we’ll be using during the Azure Spring Clean demo. The setup helps prevent non-compliant resources from being deployed using Azure Policy and Azure Pipelines. 
It also includes Microsoft Defender for Cloud, which keeps an eye on security risks in both the pipeline and the resources being deployed.

⚙️ How It Works

🛠 Step-by-Step Process
Azure Pipelines starts a deployment.
Defender for DevOps scans the pipeline for security risks (such as embedded code secrets).
The pipeline calls Azure Resource Graph to check deployment details.
Azure Policy checks the request:
✅ If it follows the rules, the deployment goes ahead.
❌ If it doesn’t, the deployment is blocked.
Defender for Cloud continues monitoring:
The pipeline settings (Defender for DevOps).
The deployed resources for any security issues or misconfigurations.
If a problem is found, alerts are logged in Defender for Cloud, and Azure Policy Compliance will generate new recommendations in the Defender for Cloud Console.

🚀 Deployment Instructions

This project can be deployed in two main ways:

### Prerequisites
- An Azure subscription
- Azure CLI installed and configured
- Terraform installed (latest version recommended)
- Azure DevOps organization with an active project
- Service Principal or Managed Identity with appropriate permissions
- An Azure storage account for Terraform state (for remote state backend)

### Option 1: Deploy via Azure Pipelines (Recommended)

#### 1. Setup Azure Pipeline for Policies

1. Navigate to your Azure DevOps project
2. Create a new pipeline using the `pipeline/pipeline.yaml` file
3. Configure the following variables:
   - `serviceConnection`: Name of your Azure service connection
   - `subscriptionId`: Your Azure subscription ID
4. Run the pipeline to deploy:
   - Azure Policy definitions from the `policies/` directory
   - Policy assignments from the `assignments/` directory
   - Microsoft Defender for DevOps security scanning

#### 2. Setup Azure Pipeline for Infrastructure

1. Create another pipeline using the `pipeline/deploy.yaml` file
2. Configure the following variables:
   - `serviceConnection`: Name of your Azure service connection
   - `backendAzureRmResourceGroupName`: Resource group for Terraform state
   - `backendAzureRmStorageAccountName`: Storage account for Terraform state
   - `backendAzureRmContainerName`: Container name (default: `tfstate`)
3. Add a variable group named `secrets` with the following variable:
   - `admin_password`: VM admin password (mark as secret)
4. Run the pipeline with parameters:
   - Set `apply: true` to deploy infrastructure
   - Set `destroy: true` to tear down infrastructure
   - Leave both false for plan-only mode

### Option 2: Deploy Locally

#### Deploy Azure Policies Manually

```bash
# Login to Azure
az login

# Set your subscription
az account set --subscription <your-subscription-id>

# Deploy policies using the script
./pipeline-scripts/deploy-policies.sh <subscription-id> ./policies/ ./assignments/subscriptions/<subscription-id>
```

#### Deploy Infrastructure with Terraform

```bash
# Navigate to terraform directory
cd terraform

# Initialize Terraform (configure backend or use local state)
terraform init

# Plan the deployment
terraform plan -var="admin_password=<your-secure-password>"

# Apply the deployment
terraform apply -var="admin_password=<your-secure-password>"

# To destroy resources
terraform destroy -var="admin_password=<your-secure-password>"
```

### What Gets Deployed

**Azure Policies:**
- VM tagging requirements policy
- Public IP denial policy

**Infrastructure (Terraform):**
- Resource Group: `AzureSpringClean2025` in UK South
- Virtual Network with subnet
- Linux Virtual Machine (Ubuntu 18.04 LTS, Standard_B1s)
- Public IP address
- Network interface

**Security:**
- Microsoft Defender for DevOps scanning
- CodeQL analysis for JavaScript code
- Dependency scanning

### Configuration Options

You can customize the deployment by modifying:
- `terraform/variable.tf`: Change location, admin username
- `policies/`: Add or modify policy definitions
- `assignments/`: Add or modify policy assignments

👥 Contributors
Jakub Fras – Cloud Security Consultant
Linkedin: https://www.linkedin.com/in/jakub-fras/

Nicholas Chang – DevOps Engineer
Linkedin: https://www.linkedin.com/in/☁%EF%B8%8F-nicholas-chang-41b83052/


📌 Quick Links
Azure Spring Clean 2025: azurespringclean.com/wall.html
Our Azure Spring Clean Submission: sessionize.com/app/speaker/session/834247
Azure Policy Docs: learn.microsoft.com/en-us/azure/governance/policy/
Microsoft Defender for Cloud: learn.microsoft.com/en-us/azure/defender-for-cloud/
Azure DevOps Security Best Practices: learn.microsoft.com/en-us/azure/devops/security/


