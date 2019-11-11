# ------------------------------------------------------------------------------
# BASIC TERRASFORM SETUP
# ------------------------------------------------------------------------------
terraform {
  required_version          = "~> 0.12"
}

provider "google" {
    version                 = "~> 2.19"
    credentials             = "C:/Users/rb/Documents/Sources/Repos/Keys/magroll-terraform-admin.json"
}

provider "random" {
    version                 = "~> 2.2"
}
