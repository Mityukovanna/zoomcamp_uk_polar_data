# credentials are set up in the github codespaces

variable "project" {
  description = "Project"
  default     = "polar-debris-pipeline"
}

variable "region" {
  description = "Region"
  default     = "europe-west21"
}

variable "location" {
  description = "Project Location"
  default     = "europe-west2"
}

variable "bq_dataset_name" {
  description = "My BigQuery Dataset Name"
  default     = "uk_polar_data"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  default     = "polar-debris-pipeline-lake"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}