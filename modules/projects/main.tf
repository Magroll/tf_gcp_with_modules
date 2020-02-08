terraform {
  required_version = ">= 0.12"
}

#--------------------------------------------Create Project--------------------------------------------
resource "google_project" "project" {
    name                        = var.project_name
    project_id                  = var.project_id
    folder_id                   = var.folder_id
    billing_account             = var.billing_id
    auto_create_network         = var.auto_create_network
}

#---------------------------Activate Compute API for initializing Networking---------------------------
resource "google_project_service" "compute_service" {
    project                     = "${google_project.project.project_id}"
    service                     = "compute.googleapis.com"
    disable_dependent_services  = true
}

#------------------------------------------Create VPC Network------------------------------------------
resource "google_compute_network" "network" {
    name                        = var.network_name
    description                 = var.network_description
    project                     = "${google_project.project.project_id}"
    auto_create_subnetworks     = var.auto_create_subnetwork
    routing_mode                = var.routing_mode
    depends_on                  = [google_project_service.compute_service]
}

#------------------------------------------Create Subnetwork------------------------------------------
resource "google_compute_subnetwork" "subnetwork" {
    name                        = var.subnetwork_name
    description                 = var.subnetwork_description
    project                     = "${google_project.project.project_id}"
    region                      = var.region
    network                     = "${google_compute_network.network.self_link}"
    ip_cidr_range               = var.subnetwork_subnet_cidr
}