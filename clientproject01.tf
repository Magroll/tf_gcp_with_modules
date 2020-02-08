# ------------------------------------------------------------------------------
# Deploy the Client Project
# ------------------------------------------------------------------------------

# Generate Random ID for Project_ID
resource "random_id" "rnd_project_id" {
  byte_length               = 4
  prefix                    = "tf-client-project01-" #EDIT HERE!
}

# Main Variable SetUp
module "clientproject" {
  source                    = "./modules/projects"
  folder_id                 = "987903443685" #EDIT HERE!
  billing_id                = "0187CC-6B5D9B-ACA38F" #EDIT HERE!
  project_name              = "tf-client-project01" #EDIT HERE!
  project_id                = "${random_id.rnd_project_id.hex}"
  network_name              = "tf-client-network01" #EDIT HERE!
  subnetwork_name           = "tf-client-subnetwork01" #EDIT HERE!
  subnetwork_subnet_cidr    = "192.168.181.0/24" #EDIT HERE!
}

# Activate Shared Client VPC
resource "google_compute_shared_vpc_service_project" "clientproject" {
  host_project              = "${module.clientproject.host_project_id}"
  service_project           = "${random_id.rnd_project_id.hex}"
}