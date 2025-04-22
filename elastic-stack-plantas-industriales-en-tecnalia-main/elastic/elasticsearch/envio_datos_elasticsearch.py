import os
from dotenv import load_dotenv
from elasticsearch import Elasticsearch
from generador_datos_sensor import generar_datos_sensor
from datos_localizacion_sedes import get_sedes
import time

load_dotenv('.env')
ELASTICSEARCH_URL = os.getenv("ELASTICSEARCH_URL")


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
        time.sleep(20)  # Espera 20 segundos


def enviar_a_elasticsearch(datos_sensores):
    for sede_clave, documento in datos_sensores.items():
        print(f"{documento}")
        es = Elasticsearch([ELASTICSEARCH_URL])
        es.index(index="datos_sedes_sensor_index", body=documento)
        # .bulk enviar un conjunto de documentos.


if __name__ == "__main__":
    enviar_documentos()
