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
    credentials = "usuario.json"
  }
}

provider "google" {
  credentials = file("usuario.json")
  project = "axiomatic-treat-361001"
  region  = "us-central1"
  zone    = "us-central1-c"
}

# Cloud Function

data "archive_file" "zip_my_function" {
  type        = "zip"
  source_dir = "function_atlas_violencia"
  output_path = "function_atlas_violencia.zip"
}

resource "google_storage_bucket_object" "archive" {
  name   = "function_atlas_violencia.zip"
  bucket = "bucket-atlas-violencia-devops"
  source = "function_atlas_violencia.zip"
}

resource "google_cloudfunctions_function" "function_atlas_violencia" {
  name        = "function_atlas_violencia"
  description = "Function do Atlas da Violencia"
  runtime     = "python39"
  entry_point           = "function_atlas_violencia"
  timeout               = 540
  available_memory_mb   = 512
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.archive.name
  event_trigger {
    event_type = "google.storage.object.finalize"
    resource   = "bucket-atlas-violencia"
  }
}

# Bigquery - Dataset

resource "google_bigquery_dataset" "default" {
  dataset_id                 = "Atlas_Violencia"
  description                = "Atlas da Violência"
}

# Bigquery - Table

resource "google_bigquery_table" "default" {
  dataset_id                 = "Atlas_Violencia"
  description                = "Homicídios por Estado"
  table_id                   = "homicidios_por_estado"
  depends_on                 = [google_bigquery_dataset.default]
  schema                     = <<EOF
  [
    {
      "name": "codigo",
      "type": "INTEGER",
      "mode": "NULLABLE",
      "description": "Codigo do Estado"
    },
    {
      "name": "estado",
      "type": "STRING",
      "mode": "NULLABLE",
      "description": "Nome do Estado"
    },
    {
      "name": "ano",
      "type": "INTEGER",
      "mode": "NULLABLE",
      "description": "Ano da Pesquisa"
    },
    {
      "name": "mortes",
      "type": "INTEGER",
      "mode": "NULLABLE",
      "description": "Quantidade de Mortes"
    }
  ]
  EOF
}