terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

terraform {
  backend "gcs" {
   bucket  = "bucket-atlas-violencia-devops"
   prefix  = "terraform/state"
 }
}

provider "google" {
  credentials = file("usuario.json")
  project = "axiomatic-treat-361001"
  region  = "us-central1"
  zone    = "us-central1-c"
}

# Cloud Storage

resource "google_storage_bucket" "default" {
  name = "bucket-atlas-violencia-2"
  location = "US"
}