# ------------------------------------------------------------------------------
# Deploy the Host Project
# ------------------------------------------------------------------------------

# Generate Random ID for Project_ID
resource "random_id" "rnd_host_project_id" {
  byte_length               = 4
  prefix                    = "tf-host-project-" #EDIT HERE!
}

# Main Variable SetUp
module "hostproject" {
  source                    = "./modules/projects"
  folder_id                 = "987903443685" #EDIT HERE!
  billing_id                = "0187CC-6B5D9B-ACA38F" #EDIT HERE!
  project_name              = "tf-host-project" #EDIT HERE!
  project_id                = "${random_id.rnd_host_project_id.hex}"
  network_name              = "tf-host-network" #EDIT HERE!
  subnetwork_name           = "tf-host-subnetwork" #EDIT HERE!
  subnetwork_subnet_cidr    = "192.168.180.0/24" #EDIT HERE!
}

# Activate Shared Host VPC
resource "google_compute_shared_vpc_host_project" "hostnetwork" {
  project                   = "${random_id.rnd_host_project_id.hex}"
}