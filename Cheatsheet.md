# Terraform Cheat Sheet

## Table of Contents

- [Essential Commands](#essential-commands)
  - [Initialization & Setup](#initialization--setup)
  - [Planning & Validation](#planning--validation)
  - [Deployment & Destruction](#deployment--destruction)
  - [State Management](#state-management)
  - [Troubleshooting Commands](#troubleshooting-commands)
- [File Structure & Naming](#file-structure--naming)
  - [Standard Files](#standard-files)
  - [Module Structure](#module-structure)
- [Variable Files & Loading](#variable-files--loading)
  - [Auto-loaded Files](#auto-loaded-files)
  - [Manual Loading](#manual-loading)
  - [Variable Precedence](#variable-precedence)
- [Terraform Block Syntax](#terraform-block-syntax)
  - [Provider Configuration](#provider-configuration)
  - [Backend Configuration](#backend-configuration)
  - [Resource Blocks](#resource-blocks)
  - [Data Sources](#data-sources)
  - [Variable Definitions](#variable-definitions)
  - [Local Values](#local-values)
  - [Outputs](#outputs)
  - [Modules](#modules)
- [Common Patterns](#common-patterns)
  - [Loops & Conditions](#loops--conditions)
  - [References](#references)
  - [Functions](#functions)
- [Workspaces](#workspaces)
  - [Workspace Commands](#workspace-commands)
  - [Workspace Usage](#workspace-usage)
- [Troubleshooting Guide](#troubleshooting-guide)
  - [Common Errors & Solutions](#common-errors--solutions)
  - [Cleanup Commands](#cleanup-commands)
- [State Management](#state-management)
  - [Local State](#local-state)
  - [Remote State](#remote-state)
  - [State Operations](#state-operations)
- [Workflow Patterns](#workflow-patterns)
  - [Basic Workflow](#basic-workflow)
  - [Production Workflow](#production-workflow)
  - [Iterative Development](#iterative-development)
  - [CI/CD Integration](#cicd-integration)
- [Best Practices](#best-practices)
  - [DO's](#dos)
  - [DON'Ts](#donts)
- [Quick Reference](#quick-reference)
  - [Emergency Commands](#emergency-commands)
  - [Debugging](#debugging)
- [Environment Variables](#environment-variables)
  - [Terraform-specific](#terraform-specific)
  - [Cloud Provider Authentication](#cloud-provider-authentication)
- [Key Reminders](#key-reminders)

## Essential Commands

### Initialization & Setup

```bash
terraform init                   # Initialize working directory
terraform init -upgrade          # Upgrade providers
terraform init -migrate-state    # Migrate state to new backend
terraform init -reconfigure      # Reconfigure backend
```

### Planning & Validation

```bash
terraform plan                   # Show execution plan
terraform plan -out=tfplan       # Save plan to file
terraform plan -destroy          # Plan destruction
terraform plan -target=resource  # Plan specific resource
terraform validate               # Validate configuration
terraform fmt                    # Format code
terraform fmt -check             # Check formatting
```

### Deployment & Destruction

```bash
terraform apply                    # Apply changes
terraform apply tfplan             # Apply saved plan
terraform apply -auto-approve      # Apply without confirmation
terraform destroy                  # Destroy all resources
terraform destroy -auto-approve    # Destroy without confirmation
terraform destroy -target=resource # Destroy specific resource
```

### State Management

```bash
terraform show                   # Show current state
terraform state list             # List resources in state
terraform state show resource    # Show specific resource
terraform refresh                # Refresh state
terraform import addr id         # Import existing resource
terraform state rm resource      # Remove from state
terraform state mv old new       # Move/rename resource
```

### Troubleshooting Commands

```bash
terraform force-unlock LOCK_ID  # Force unlock state
terraform console               # Interactive console
terraform graph                 # Generate dependency graph
terraform output                # Show output values
terraform output -json          # Show outputs as JSON
```

---

## File Structure & Naming

### Standard Files

```
project/
├── main.tf              # Main configuration
├── variables.tf         # Variable definitions
├── outputs.tf           # Output definitions
├── provider.tf          # Provider configuration
├── backend.tf           # Backend configuration
├── terraform.tfvars     # Variable values (auto-loaded)
├── versions.tf          # Version constraints
└── locals.tf            # Local values
```

### Module Structure

```
modules/
└── my-module/
    ├── main.tf          # Module resources
    ├── variables.tf     # Module inputs
    ├── outputs.tf       # Module outputs
    └── README.md        # Documentation
```

---

## Variable Files & Loading

### Auto-loaded Files

Files loaded automatically in this order:

```
terraform.tfvars         # Main variables
terraform.tfvars.json    # JSON format
*.auto.tfvars            # Auto-loaded (alphabetical)
*.auto.tfvars.json       # Auto-loaded JSON
```

### Manual Loading

```bash
terraform apply -var-file="prod.tfvars"
terraform apply -var="key=value"
terraform apply -var-file="file1.tfvars" -var-file="file2.tfvars"
```

### Variable Precedence

Priority from highest to lowest:

1. **CLI flags**: `-var="key=value"`
2. **Environment vars**: `TF_VAR_key=value`
3. **terraform.tfvars**
4. **terraform.tfvars.json**
5. **.auto.tfvars**
6. **Default values**
7. **Interactive prompt**

---

## Terraform Block Syntax

### Provider Configuration

```hcl
terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}
```

### Backend Configuration

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "stterraformstate"
    container_name       = "tfstate"
    key                  = "prod/terraform.tfstate"
  }
}
```

### Resource Blocks

```hcl
resource "resource_type" "resource_name" {
  # Required arguments
  name                = var.resource_name
  location            = var.location
  resource_group_name = var.resource_group_name

  # Optional arguments
  tags = var.tags

  # Nested blocks
  network_interface {
    name                 = "internal"
    primary              = true
    ip_configuration {
      name                          = "internal"
      subnet_id                     = var.subnet_id
      private_ip_address_allocation = "Dynamic"
    }
  }

  # Meta-arguments
  count      = var.instance_count
  for_each   = var.instances
  depends_on = [azurerm_resource_group.example]

  # Lifecycle rules
  lifecycle {
    create_before_destroy = true
    ignore_changes       = [tags]
    prevent_destroy      = true
  }
}
```

### Data Sources

```hcl
data "azurerm_resource_group" "example" {
  name = "existing-rg"
}

data "azurerm_client_config" "current" {}

data.azurerm_client_config.current.tentant_id
```

### Variable Definitions

```hcl
variable "name" {
  description = "Description here"
  type        = string
  default     = "default-value"
  sensitive   = true
  validation {
    condition     = length(var.name) > 0
    error_message = "Name cannot be empty."
  }
}

# Variable types
variable "string_var" {
  type = string
}

variable "number_var" {
  type = number
}

variable "bool_var" {
  type = bool
}

variable "list_var" {
  type = list(string)
}

variable "map_var" {
  type = map(string)
}

variable "object_var" {
  type = object({
    name = string
    age  = number
  })
}
```

### Local Values

```hcl
locals {
  common_tags = {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
  }

  resource_prefix = "${var.project_name}-${var.environment}"
}
```

### Outputs

```hcl
output "name" {
  description = "Description here"
  value       = resource.name.attribute
  sensitive   = true
}

output "complex_output" {
  value = {
    id   = azurerm_resource_group.example.id
    name = azurerm_resource_group.example.name
  }
}
```

### Modules

```hcl
module "example" {
  source = "./modules/example"

  input_var = var.my_variable
  count     = 3
  for_each  = var.my_map

  depends_on = [azurerm_resource_group.example]
}
```

---

## Common Patterns

### Loops & Conditions

```hcl
# For Each
resource "azurerm_resource_group" "rg" {
  for_each = var.resource_groups
  name     = each.key
  location = each.value
}

# Count
resource "azurerm_virtual_machine" "vm" {
  count = var.vm_count
  name  = "vm-${count.index}"
}

# Conditional
resource "azurerm_storage_account" "storage" {
  count = var.create_storage ? 1 : 0
  name  = var.storage_name
}

# Dynamic blocks
resource "azurerm_network_security_group" "example" {
  dynamic "security_rule" {
    for_each = var.security_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}
```

### References

```hcl
# Resource attributes
resource.name.attribute

# Module outputs
module.name.output_name

# Variables
var.variable_name

# Local values
local.value_name

# Data sources
data.source_type.name.attribute
```

### Functions

```hcl
# String functions
upper(var.name)
lower(var.name)
length(var.name)
substr(var.name, 0, 3)
replace(var.name, "old", "new")

# Collection functions
concat(var.list1, var.list2)
contains(var.list, "value")
keys(var.map)
values(var.map)
merge(var.map1, var.map2)

# Numeric functions
max(var.num1, var.num2)
min(var.num1, var.num2)
ceil(var.number)
floor(var.number)

# Date functions
timestamp()
formatdate("YYYY-MM-DD", timestamp())

# Encoding functions
base64encode(var.string)
base64decode(var.encoded_string)
jsonencode(var.object)
jsondecode(var.json_string)

# Filesystem functions
file(var.file_path)
templatefile(var.template_path, var.variables)
```

---

## Workspaces

### Workspace Commands

```bash
terraform workspace list          # List workspaces
terraform workspace new dev       # Create new workspace
terraform workspace select dev    # Switch to workspace
terraform workspace delete dev    # Delete workspace
terraform workspace show          # Show current workspace
```

### Workspace Usage

```hcl
# Reference current workspace
resource "azurerm_resource_group" "example" {
  name     = "rg-${terraform.workspace}"
  location = var.location
}

# Conditional based on workspace
locals {
  instance_count = terraform.workspace == "prod" ? 3 : 1
}
```

---

## Troubleshooting Guide

### Common Errors & Solutions

| **Error**                 | **Solution**                              |
| ------------------------- | ----------------------------------------- |
| `State locked`            | `terraform force-unlock LOCK_ID`          |
| `Provider not found`      | `terraform init`                          |
| `Stale plan`              | `rm tfplan && terraform plan`             |
| `Version conflicts`       | `terraform init -upgrade`                 |
| `Module not found`        | `terraform init`                          |
| `Backend changed`         | `terraform init -migrate-state`           |
| `Resource already exists` | `terraform import resource_addr id`       |
| `Configuration invalid`   | `terraform validate`                      |
| `Formatting issues`       | `terraform fmt`                           |
| `Circular dependency`     | Review resource dependencies              |
| `Timeout errors`          | Increase timeout or check resource status |

### Cleanup Commands

```bash
# Nuclear option (start fresh)
rm -rf .terraform .terraform.lock.hcl terraform.tfstate* tfplan

# Gentle cleanup
terraform refresh
terraform plan
terraform apply

# Fix corrupted state
terraform state pull > backup.tfstate
terraform state push backup.tfstate
```

---

## State Management

### Local State

```
terraform.tfstate        # Current state
terraform.tfstate.backup # Previous state
```

### Remote State

```hcl
terraform {
  backend "azurerm" {
    # Configuration here
  }
}
```

### State Operations

```bash
terraform state list                    # List all resources
terraform state show resource           # Show resource details
terraform state rm resource             # Remove from state
terraform state mv old_name new_name    # Rename resource
terraform import resource_addr id       # Import existing resource
terraform state pull                    # Download remote state
terraform state push                    # Upload local state
```

---

## Workflow Patterns

### Basic Workflow

```bash
1. terraform init
2. terraform plan -out=tfplan
3. terraform apply tfplan
4. terraform destroy (when/if done)
```

### Production Workflow

```bash
1. terraform init
2. terraform validate
3. terraform fmt -check
4. terraform plan -out=tfplan
5. Review plan
6. terraform apply tfplan
7. terraform output
```

### Iterative Development

```bash
# Make changes
terraform plan
terraform apply

# Test changes
terraform output

# Rollback if needed
terraform destroy -target=resource
```

### CI/CD Integration

```bash
# Validation pipeline
terraform init
terraform validate
terraform fmt -check
terraform plan -detailed-exitcode

# Deployment pipeline
terraform init
terraform plan -out=tfplan
terraform apply tfplan
terraform output -json > outputs.json
```

---

## Best Practices

### DO's

- Use remote state for teams
- Version your modules
- Use descriptive names
- Add validation rules
- Document your code
- Use consistent formatting
- Plan before apply
- Use .gitignore for secrets/sensitive data/.tfstate
- Use modules for reusability
- Implement proper tagging
- Use workspaces for environments
- Regular state backups
- Use data sources for existing resources
- Implement proper error handling
- Use lifecycle rules appropriately

### DON'Ts

- Don't edit state files manually
- Don't commit .tfstate files
- Don't use hardcoded values
- Don't skip planning
- Don't ignore warnings
- Don't use admin credentials
- Don't deploy without testing
- Don't share credentials in code
- Don't ignore resource dependencies
- Don't use deprecated syntax
- Don't create circular dependencies
- Don't ignore state drift
- Don't use count and for_each together

---

## Quick Reference

### Emergency Commands

```bash
# Everything is broken
rm -rf .terraform* terraform.tfstate* tfplan
terraform init
terraform plan

# State is corrupted
terraform refresh
terraform import resource_type.name resource_id

# Locked state
terraform force-unlock LOCK_ID

# Start over
terraform destroy -auto-approve
terraform apply -auto-approve

# Fix drift
terraform refresh
terraform plan
terraform apply
```

### Debugging

```bash
export TF_LOG=DEBUG                     # Enable debug logging
export TF_LOG=INFO                      # Less verbose logging
export TF_LOG_PATH=terraform.log        # Log to file
terraform console                       # Interactive console
terraform graph | dot -Tpng > graph.png # Visualize dependencies (graphviz)
terraform show -json                    # JSON output
```

---

## Environment Variables

### Terraform-specific

```bash
export TF_LOG=DEBUG                        # Enable debug logging
export TF_LOG_PATH=./terraform.log         # Log file location
export TF_VAR_variable_name=value          # Set variable value
export TF_CLI_ARGS_plan="-parallelism=10"  # CLI arguments
export TF_DATA_DIR=.terraform              # Data directory
export TF_WORKSPACE=dev                    # Set workspace
```

### Cloud Provider Authentication

```bash
# Azure
export ARM_CLIENT_ID="your-client-id"
export ARM_CLIENT_SECRET="your-client-secret"
export ARM_SUBSCRIPTION_ID="your-subscription-id"
export ARM_TENANT_ID="your-tenant-id"

# AWS
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_DEFAULT_REGION="us-west-2"

# Google Cloud
export GOOGLE_APPLICATION_CREDENTIALS="path/to/service-account.json"
export GOOGLE_PROJECT="your-project-id"
```

---

## Key Reminders

**Critical Points to Remember:**

- **Always plan before apply** - Never skip the planning phase
- **Use version control** - Track all infrastructure changes
- **Keep state files secure** - Never commit state to public repos
- **Document your infrastructure** - Future you will thank present you
- **Test in non-production first** - Validate changes safely
- **Use modules for reusability** - Don't repeat yourself
- **Monitor your resources** - Keep track of what's deployed
- **Clean up unused resources** - Avoid unnecessary costs
- **Backup your state** - Regularly backup remote state
- **Use consistent naming** - Follow naming conventions
- **Implement proper security** - Use least privilege access
- **Regular updates** - Keep providers and modules updated
- **Understand dependencies** - Know what depends on what
- **Use appropriate data types** - Choose the right variable types
- **Handle sensitive data properly** - Use sensitive variables

---

**Tags**: #terraform #infrastructure #devops #cloud #automation #cheatsheet
