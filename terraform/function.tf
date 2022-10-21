data "archive_file" "zip_my_function" {
  type        = "zip"
  source_dir = "../function_atlas_violencia"
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
  source_archive_bucket = "bucket-atlas-violencia-devops"
  source_archive_object = google_storage_bucket_object.archive.name
  event_trigger {
    event_type = "google.storage.object.finalize"
    resource   = "bucket-atlas-violencia"
  }
}