import os
from dotenv import load_dotenv
from elasticsearch import Elasticsearch
from generador_datos_sensor import generar_datos_sensor
from datos_localizacion_sedes import get_sedes
import time

load_dotenv('.env')
ELASTICSEARCH_URL = os.getenv("ELASTICSEARCH_URL")
ELASTIC_CLOUD_ID = os.getenv("ELASTIC_CLOUD_ID")
ELASTIC_CLOUD_API_KEY = os.getenv("ELASTIC_CLOUD_API_KEY")
ELASTIC_CLOUD_INDEX = os.getenv("ELASTIC_CLOUD_INDEX", "datos_sedes_sensor_index")


def enviar_documentos():
    lista_sedes = get_sedes()

    while True:
        # Diccionario para almacenar los datos de todos los sensores y ubicaciones
        datos_sensores = {}

        for sede_clave, sede_info in lista_sedes.items():
            sensor_datos = generar_datos_sensor()

            # Para juntar datos de la sede a los datos del sensor en un mismo documento
            documento = {
                "sede_info": sede_info,
                "sensor_datos": sensor_datos
            }

            datos_sensores[sede_clave] = documento

        enviar_a_elasticsearch(datos_sensores)
        
        # Solo enviamos a Elastic Cloud si está configurado
        if ELASTIC_CLOUD_ID and ELASTIC_CLOUD_API_KEY:
            enviar_a_elasticcloud(datos_sensores)
            
        time.sleep(20)  # Espera 20 segundos


def enviar_a_elasticsearch(datos_sensores):
    for sede_clave, documento in datos_sensores.items():
        print(f"Enviando datos de {sede_clave} a Elasticsearch local")
        es = Elasticsearch([ELASTICSEARCH_URL])
        es.index(index="datos_sedes_sensor_index", body=documento)
        # .bulk enviar un conjunto de documentos.


def enviar_a_elasticcloud(datos_sensores):
    try:
        # Conexión a Elastic Cloud usando API Key
        es_cloud = Elasticsearch(
            cloud_id=ELASTIC_CLOUD_ID,
            api_key=ELASTIC_CLOUD_API_KEY,
            verify_certs=True  # Mantener para verificar certificados de Elastic Cloud
        )
        
        for sede_clave, documento in datos_sensores.items():
            print(f"Enviando datos de {sede_clave} a Elastic Cloud")
            es_cloud.index(index=ELASTIC_CLOUD_INDEX, body=documento)
            
    except Exception as e:
        print(f"Error al enviar datos a Elastic Cloud: {e}")


if __name__ == "__main__":
    enviar_documentos()