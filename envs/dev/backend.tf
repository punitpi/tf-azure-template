# For local development comment the below backend block
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-dev-tfstate"
    storage_account_name = "puneethdevtfstate"
    container_name       = "state"
    key                  = "dev/terraform.tfstate"
  }
}


# To use remote state from local:
# 1. Create a storage account for Terraform state
# 2. Uncomment the backend block above
# 3. Update the values with your storage account details
# 4. Run: terraform init -migrate-state
