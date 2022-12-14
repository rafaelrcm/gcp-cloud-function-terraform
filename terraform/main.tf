terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }

  backend "gcs" {
    bucket  = "bucket-atlas-violencia-devops"
    prefix  = "terraform/state"
    credentials = "../usuario.json"
  }
}

provider "google" {
  credentials = file("../usuario.json")
  project = "axiomatic-treat-361001"
  region  = "us-central1"
  zone    = "us-central1-c"
}