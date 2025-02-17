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


