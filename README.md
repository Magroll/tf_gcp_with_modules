## Manual First Setup Steps:
Based on https://cloud.google.com/community/tutorials/managing-gcp-projects-with-terraform \
Open GCloud Console

### Get needed Data (YOUR_ORG_ID & YOUR BILLING ACCOUNT)
gcloud organizations list \
gcloud beta billing accounts list 

### Setup Environment in gcloud
export TF_VAR_org_id=YOUR_ORG_ID \
export TF_VAR_billing_account=YOUR_BILLING_ACCOUNT_ID \
export TF_ADMIN=${USER}-terraform-admin \
export TF_CREDS=~/.config/gcloud/${USER}-terraform-admin.json

### Create Terraform Admin Project:
gcloud projects create ${TF_ADMIN} \
  --organization ${TF_VAR_org_id} \
  --set-as-default
  
gcloud beta billing projects link ${TF_ADMIN} \
  --billing-account ${TF_VAR_billing_account}

### Create the Terraform service account and set some rights
gcloud iam service-accounts create terraform \
  --display-name "Terraform admin account"
  
gcloud iam service-accounts keys create ${TF_CREDS} \
  --iam-account terraform@${TF_ADMIN}.iam.gserviceaccount.com
  
- Download Key: /home/*Username*/.config/gcloud/*Username*-terraform-admin.json

gcloud projects add-iam-policy-binding ${TF_ADMIN} \
  --member serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com \
  --role roles/viewer
  
gcloud organizations add-iam-policy-binding ${TF_VAR_org_id} \
  --member serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com \
  --role roles/resourcemanager.folderAdmin
  
gcloud organizations add-iam-policy-binding ${TF_VAR_org_id} \
  --member serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com \
  --role roles/billing.user

### Activate needed APIs
gcloud services enable cloudresourcemanager.googleapis.com \
gcloud services enable cloudbilling.googleapis.com \
gcloud services enable iam.googleapis.com \
gcloud services enable compute.googleapis.com \
gcloud services enable serviceusage.googleapis.com

### Set up remote state in Cloud Storage (optional / if wanted)
gcloud projects add-iam-policy-binding ${TF_ADMIN} \
  --member serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com \
  --role roles/storage.admin

gsutil mb -p ${TF_ADMIN} gs://${TF_ADMIN} \
  cat > backend.tf << EOF \
  terraform { \
  backend "gcs" { \
     bucket  = "${TF_ADMIN}" \
     prefix  = "terraform/state" \
   } \
  } \
  EOF

gsutil versioning set on gs://${TF_ADMIN}

# -----------------------------------------

# tf_gcp_first
- First Terraform Project in GCP
- Based on https://learn.hashicorp.com/terraform/gcp/intro

## Manual Steps:
- Create GCP Account
- Create Organisation
- Create Folder 
- Goto IAM & Management / Service Accounts
  - Create new GCP Service Account for Terraform
  - Apply Role "Project -> Editor" to new Service Account
  - Download Key File
  - Store Key in Keys Directory in Projectfolder
- Edit "project" Variable in terraform.tfvars
- Edit "credentials_file" Variable in terraform.tfvars 

## Tools used:
- Coded with Visual Studio Code
