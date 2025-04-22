# Elastic Stack-Plantas Industriales en Tecnalia - Garai Mtz. de Santos 

## Descripción del proyecto

Este proyecto simula la generación de datos de sensores en una red de plantas industriales. 
Los datos generados incluyen mediciones de humedad, temperatura, luminosidad, entre otros. Los datos se envían a Elasticsearch y se visualizan en un dashboard de Kibana. Además, se capturan datos meteorológicos en las diferentes localizaciones de las plantas industriales.

## Tecnologías Utilizadas

   - Python: En nuestro proyecto, se usa Python para crear un programa que simula datos de sensores y que sirve para enviar estos datos a elasticsearch. Esto nos ayuda a generar datos de los sensores en cada una de las sedes.
   - Elasticsearch: Es un motor de búsqueda y de análisis en tiempo real, el cual ha sido utilizado para almacenar todos los datos relativos a nuestro proyecto. Habrán varios índices, creados con objetivo de distinguir los tipos de datos y posteriormente poder visualizarlos en Kibana fácilmente.
   - Kibana: Es una herramienta de visualización de datos de Elasticsearch que proporciona visualización de los datos en tiempo real. En este caso se utiliza para visualizar en Dashboards todos los datos del proyecto de una manera atractiva.
   - Logstash: Es una herramienta de procesamiento de datos que es capaz de obtener datos de múltiples fuentes simultáneamente, de transformarlos y luego enviarlos a Elasticsearch. Ha sido utilizado para obtener distintos datos meteorológicos de una api web mediante el plugin http_poller. Se han utilizado dos pipelines.
   - Metricbeat: Es un agente de envío ligero que recopila y envía métricas del sistema y de los servicios en ejecución. Ha sido implementado con objetivo de monitorizar el uso de Docker y de los distintos servicios que proporciona el proyecto.
   - Docker y Docker Compose: Son herramientas que nos permiten empacar y desplegar fácilmente todos los servicios del proyecto. Docker actúa como un contenedor para cada uno de nuestros servicios, asegurando que funcionen sin problemas. Por su parte, Docker Compose se encarga de coordinar estos contenedores, facilitando la administración y puesta en marcha de nuestro sistema de manera eficiente.

## Módulos

### Simulador de Datos de Sensores

Este módulo genera datos aleatorios para diferentes parámetros como la humedad, la temperatura, la luminosidad, la presión, etc. Los datos se generan cada 20 segundos.

### Envío de Datos a Elasticsearch

Este módulo toma los datos generados por el simulador de datos de sensores y los envía a un índice de Elasticsearch.

### Dockerización del Simulador de Datos

Este módulo contiene un Dockerfile para el simulador de datos y está configurado para que ejecute su código correspondiente.

### Captura de Datos Meteorológicos

Este módulo utiliza Logstash con el plugin http_poller para obtener datos meteorológicos de una API y enviarlos a Elasticsearch.

### Visualización de la Información

Este módulo utiliza Kibana para crear un dashboard que muestre los datos de los sensores y los distintos datos meteorológicos.

### Monitorización del Servicio de Docker

Este módulo utiliza Metricbeat para monitorizar el servicio de Docker y ver información sobre los contenedores que están levantados.


## Cómo Usar

    Asegúrate de tener instalado Docker y Docker Compose.
    Clona este repositorio de Git.
    Navega al directorio del proyecto.
    Ejecuta docker-compose up para iniciar los servicios.
    Abre Kibana en tu navegador para visualizar los datos, hazlo insertando en el navegador http://localhost:5601.

## Notas Adicionales

Este proyecto utiliza Python 3.10.1. Las dependencias de Python están especificadas en el archivo requirements.txt.

