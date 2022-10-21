resource "google_bigquery_dataset" "default" {
  dataset_id                 = "Atlas_Violencia"
  description                = "Atlas da Violência"
}

resource "google_bigquery_table" "default" {
  dataset_id                 = "Atlas_Violencia"
  description                = "Homicídios por Estado"
  table_id                   = "homicidios_por_estado"
  depends_on                 = [google_bigquery_dataset.default]
  schema                     = file("${path.root}/schema/schema.json")
}