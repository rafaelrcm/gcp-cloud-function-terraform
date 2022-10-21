resource "google_bigquery_dataset" "default" {
  dataset_id                 = "Atlas_Violencia"
  description                = "Atlas da Violência"
}

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