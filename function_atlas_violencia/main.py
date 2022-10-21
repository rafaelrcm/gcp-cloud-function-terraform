import pandas as pd

def function_atlas_violencia(event, context):

    file = f"gs://{event['bucket']}/{event['name']}"

    df = pd.read_csv(file, sep=';', encoding='utf8')

    df.columns = ['codigo', 'estado', 'ano', 'mortes']

    df.to_gbq(destination_table="Atlas_Violencia.homicidios_por_estado", if_exists='replace')