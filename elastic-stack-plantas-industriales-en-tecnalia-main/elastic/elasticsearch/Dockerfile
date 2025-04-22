FROM python:3.10.1

COPY .env /app/

COPY envio_datos_elasticsearch.py /app/envio_datos_elasticsearch.py

COPY generador_datos_sensor.py /app/generador_datos_sensor.py

COPY datos_localizacion_sedes.py /app/datos_localizacion_sedes.py

COPY requirements.txt /app/

WORKDIR /app

RUN pip install -r requirements.txt

CMD ["python", "envio_datos_elasticsearch.py"]