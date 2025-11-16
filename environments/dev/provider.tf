terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.49.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "317171c4-8a0b-428f-b95a-d30f5ecb1162"

}

