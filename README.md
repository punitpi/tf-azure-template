# Terraform Azure Proof of Concept

This repository contains a modular Terraform configuration for deploying Azure infrastructure components as a proof of concept.

## Architecture Overview

This PoC deploys the following Azure resources:

- **Resource Group**: Container for all resources
- **Virtual Network**: Network infrastructure with subnets
- **Storage Account**: Blob storage with containers
- **Key Vault**: Secure storage for secrets and keys
- **App Service**: Web application hosting with App Service Plan

## Repository Structure

```text
├── envs
│   └── dev
│       ├── backend.tf
│       ├── graph.png
│       ├── main.tf
│       ├── outputs.tf
│       ├── provider.tf
│       ├── terraform.tfvars
│       ├── terraform.tfvars.example
│       ├── tfplan
│       └── variables.tf
├── modules
│   ├── app_service
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── README.md
│   │   └── variables.tf
│   ├── key_vault
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── README.md
│   │   └── variables.tf
│   ├── resource_group
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── README.md
│   │   └── variables.tf
│   ├── storage_account
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── README.md
│   │   └── variables.tf
│   └── virtual_network
│       ├── main.tf
│       ├── outputs.tf
│       ├── README.md
│       └── variables.tf
├── Cheatsheet.md
├── LICENSE
└── README.md
```
