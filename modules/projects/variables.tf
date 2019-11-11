# ---------------------------------------------------------------------------------------------------------------------
# Variables for Module "Projects"
# ---------------------------------------------------------------------------------------------------------------------
# -------------------------------------------------Project Variables---------------------------------------------------

variable "folder_id" {
    description             = "The ID of the folder in which the projects should be placed (gcloud organizations list)"
    type                    = string
}

variable "billing_id" {
    description             = "The billing Account the Project is related to (gcloud beta billing accounts list)"
    type                    = string
}

variable "project_name" {
    description             = "The Name of the Project"
    type                    = string
}

variable "project_id" {
    description             = "The id of the Project"
    type                    = string
}

#Optional
variable "auto_create_network" {
    description             = "Creating autonetwoks or not"
    type                    = string
    default                 = "false"
}

# -----------------------------------------------Networking Variables---------------------------------------------------

variable "network_name" {
    description             = ""
    type                    = string
}

#Optional
variable "network_description" {
    description             = ""
    type                    = string
    default                = "Terraform Resource"
}

#Optional
variable "auto_create_subnetwork" {
    description             = "Creating autonetwoks or not"
    type                    = string
    default                 = "false"
}

#Optional
variable "routing_mode" {
    description             = "Creating autonetwoks or not"
    type                    = string
    default                 = "GLOBAL"
}

# -----------------------------------------------Subnetworking Variables-----------------------------------------------

variable "subnetwork_name" {
    description             = ""
    type                    = string
}

variable "subnetwork_subnet_cidr" {
    description             = ""
    type                    = string
}

#Optional
variable "subnetwork_description" {
    description             = ""
    type                    = string
    default                = "Terraform Resource"
}

#Optional
variable "region" {
    description             = ""
    type                    = string
    default                = "europe-west3"
}