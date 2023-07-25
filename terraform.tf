terraform {
  backend "gcs" {
    bucket                      = "<BUCKET_NAME>"
    prefix                      = "terraform-states"
    impersonate_service_account = "<SERVICE_ACCOUNT_EMAIL>"
  }
}
