🚀 Three-Tier Landing Zone – Generic Azure Terraform Modules

This repository contains a modular, reusable, and scalable Landing Zone implementation on Microsoft Azure, built entirely using Terraform.
It follows enterprise architecture patterns, governance standards, security best-practices, and multi-environment design.

📌 Features
✔ Modular & reusable Terraform blocks
✔ Three-tier cloud architecture
✔ Azure recommended best practices
✔ Multi-environment (Dev / QA / Prod)
✔ RBAC & network security enabled
✔ App Gateway / VMSS / VNet modules included
✔ Production-ready folder structure
✔ Easy to extend (containers, AKS, Postgres, Redis, etc.)

🏗️ Three Tier Architecture Overview
Tier 1 – Ingress Layer
	•	App Gateway
	•	Azure Firewall / WAF
	•	Bastion
	•	Public/Private Load Balancers

Tier 2 – Application Layer
	•	Virtual Machines
	•	VM Scale Sets
	•	App Services
	•	AKS Pods / Microservices

Tier 3 – Data Layer
	•	Azure Storage
	•	SQL/PostgreSQL
	•	Key Vault
	•	Redis Cache
  
three-tier-landing-zone-generic-block/
│
├── README.md
├── LICENSE
│
├── 1-global/
│   ├── provider.tf
│   ├── backend.tf
│   ├── variables.tf
│   └── outputs.tf
│
├── 2-networking/
│   ├── vnet/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   └── subnet/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
│
├── 3-security/
│   ├── nsg/
│   │   ├── main.tf
│   │   └── variables.tf
│   └── keyvault/
│       ├── main.tf
│       └── variables.tf
│
├── 4-compute/
│   ├── vm/
│   │   ├── main.tf
│   │   └── variables.tf
│   │
│   └── vmss/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
│
├── 5-ingress/
│   ├── app-gateway/
│   │   ├── main.tf
│   │   └── variables.tf
│   │
│   └── firewall/
│       ├── main.tf
│       └── variables.tf
│
├── environments/
│   ├── dev/
│   │   ├── main.tf
│   │   └── tfvars
│   ├── qa/
│   └── prod/
│
└── scripts/
    ├── deploy.sh
    ├── destroy.sh
    └── validate.sh

⚙️ How to Deploy

1️⃣ Initialize Terraform: terraform init

2️⃣ Validate Configuration: terraform validate

3️⃣ Generate Execution Plan: terraform plan -var-file="dev.tfvars"

4️⃣ Apply Changes: terraform apply -var-file="dev.tfvars" -auto-approve

🔐 Security Best Practices
	•	Store secrets in Azure Key Vault
	•	Enable NSG + Azure Firewall
	•	Use User Access Administrator for role assignments
	•	No secrets inside .tf or GitHub repo
	•	Enable Defender for Cloud

🤖 CI/CD Support
The project supports automated deployment through:
	•	GitHub Actions (Recommended)
	•	Azure DevOps Pipelines
	•	Terraform Cloud

👉 Self-hosted runner + OIDC authentication supported.

📌 Prerequisites
	•	Terraform ≥ 1.6
	•	Azure Subscription
	•	Service Principal with:
	•	Contributor
	•	User Access Administrator (for role assignments)

🛡️ Governance & RBAC
This landing zone supports:
	•	Naming standards
	•	Resource tagging
	•	IAM/RBAC
	•	Role assignments
	•	Least privilege model

📈 Future Enhancements
	•	AKS module
	•	Policies module
	•	Monitoring module
	•	APM (Log Analytics, Application Insights)
	•	Hub-Spoke network automation

👨‍💻 Author
Raju Verma — DevOps Engineer (RIL)
Specializing in:
	•	Azure Cloud
	•	Terraform
	•	CI/CD & GitHub Actions
	•	Enterprise Landing Zones

