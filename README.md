
# Elastic Stack - Plantas Industriales en Tecnalia

## Descripción del Proyecto

Este proyecto simula un entorno industrial distribuido con múltiples plantas en distintas localizaciones. Se generan datos de sensores (temperatura, humedad, luminosidad, presión, etc.) que se envían a Elasticsearch para su análisis y visualización en tiempo real mediante Kibana. Además, se integran datos meteorológicos de fuentes externas para enriquecer la información de cada sede. También se incluye un módulo de RAG (Retrieval-Augmented Generation) que permite realizar preguntas en lenguaje natural sobre los datos almacenados (únicamente los de los sensores de las sedes), ofreciendo respuestas generadas a partir de información recuperada desde Elasticsearch.

## Miembros del Equipo

- Markel Aguirre  
- Garai Martínez de Santos  
- Pablo Ruiz de Azúa  

## Tecnologías Utilizadas

- **Python**: Simulación de datos de sensores y envío a Elasticsearch.
- **Elasticsearch y elastic cloud**: Almacenamiento de los datos de sensores y meteorológicos, y motor de recuperación para el módulo RAG.
- **Kibana**: Visualización de los datos a través de dashboards interactivos.
- **Logstash**: Captura de datos meteorológicos desde una API externa utilizando el plugin http_poller.
- **Metricbeat**: Monitorización de los recursos del sistema y contenedores Docker.
- **Docker & Docker Compose**: Orquestación y despliegue de todos los servicios del proyecto.
- **Retrieval-Augmented Generation (RAG)**: Combinación de recuperación de información con generación de lenguaje natural para responder preguntas sobre los datos de los sensores en Elasticsearch mediante un modelo de lenguaje (LLM, deepseek r1).

## Estructura de los Módulos

### 1. Simulador de Datos de Sensores

Genera datos aleatorios para cada sede industrial cada 20 segundos, emulando sensores físicos.

### 2. Envío de Datos a Elasticsearch

Los datos generados por el simulador se indexan directamente en Elasticsearch.

### 3. Dockerización del Simulador

Incluye un Dockerfile que ejecuta automáticamente el script de simulación en su contenedor.

### 4. Captura de Datos Meteorológicos

Logstash se encarga de recoger datos desde una API meteorológica usando pipelines configurados con http_poller.

### 5. Visualización de Datos

Kibana permite explorar y analizar todos los datos a través de dashboards configurados.

### 6. Monitorización del Sistema

Metricbeat se encarga de reportar métricas del sistema y contenedores activos al stack.

### 7. Módulo RAG (Retrieval-Augmented Generation)

Este módulo permite realizar preguntas en lenguaje natural sobre los datos almacenados de los sensores de las sedes en Elasticsearch, usando elastic cloud. Utiliza una combinación de recuperación de documentos y generación de lenguaje para ofrecer respuestas precisas y contextualizadas. Se apoya en un modelo de lenguaje (LLM, deepseek r1) y en el motor de búsqueda de Elasticsearch para recuperar los datos relevantes. Su interfaz es un notebook o una aplicación web que interactúa con el backend o con el mismo notebook.

## Instrucciones de Uso

### 1. Requisitos Previos

- Tener instalado Docker y Docker Compose.
- Clonar este repositorio:

```bash
git clone https://github.com/garaimg/proyecto-final-iot
cd proyecto-final-iot/
cd elastic-stack-plantas-industriales/
```

### 2. Ejecución del Sistema

Levantar todos los contenedores con el siguiente comando:

```bash
docker compose up --build
```

### 3. Acceso a Kibana

Una vez desplegado, accede a Kibana desde tu navegador en:

```
http://localhost:5601
```

### 4. Importar el Dashboard

Para visualizar la información:

1. Ve a "Stack Management" → "Saved Objects".
2. Haz clic en "Import".
3. Selecciona el archivo `sedes_dashboard.ndjson`.
4. Acepta la opción "Automatically overwrite conflicts".

## Instrucciones RAG (Retrieval-Augmented Generation)

Se incluye un componente de RAG (Retrieval-Augmented Generation) que permite responder preguntas sobre los datos de los sensores de las sedes recopilados en el sistema elastic cloud. De esta manera, es posible realizar preguntas en lenguaje natural como "¿Cuál fue la temperatura media obtenida por los sensores en la planta de Serbia la anterior hora?" y obtener respuestas contextualizadas.

Este módulo de RAG se basa en:

- **Elasticsearch, dentro de elastic cloud** como motor de recuperación de documentos relevantes.
- **Un modelo de lenguaje (LLM), deepseek r1** que sintetiza y responde con base en los datos recuperados.
- **Interfaz web** y notebook para realizar consultas interactivas.

## Instrucciones de Uso

Pasos:
1. Lanzar todo el colab: https://colab.research.google.com/drive/1Vbvl90AXtjo6-TWVzb34C7nVUex1Pv6T?usp=sharing
2. Copiar la URL pública y ponerla en el index.html, el cual está dentro de la carpeta RAG del proyecto.
3. Ejecutar `python3 -m http.server 8080` en la carpeta del `index.html`
4. Entrar en `localhost:8080` desde el navegador

Enlace notebook: https://colab.research.google.com/drive/1Vbvl90AXtjo6-TWVzb34C7nVUex1Pv6T?usp=sharing

## Posibles Vías de Mejora

- Añadir autenticación y control de acceso a Elasticsearch y Kibana.
- Incluir detección de anomalías en tiempo real mediante Machine Learning (ej. River o modelos de ML de Elastic).
- Simulación más compleja basada en comportamiento real de sensores industriales.

## Alternativas Posibles

- Sustitución de Logstash por Filebeat o Mage AI.
- Uso de otras herramientas de visualización como Grafana con Elasticsearch como fuente.
- Implementación de servicios en la nube con Elastic Cloud o AWS Elasticsearch Service.

## Dificultades Encontradas

### Elasticsearch

- Necesidad de unificar los datos de sensores junto con la localización de cada planta para que estén en un único índice.
- Generación simultánea de datos por planta: fue necesario adaptar el simulador para emitir datos para todas las sedes, no solo una.

### Logstash

- Dificultad para encontrar una API meteorológica gratuita con suficientes solicitudes disponibles.
- Requirió configurar una URL específica por planta para obtener datos meteorológicos por localización.
- Uso de `pipelines.yml` para ejecutar múltiples pipelines simultáneamente.
- Se implementó un script `index.sh` para evitar que los índices se generen automáticamente sin mappings.

### Kibana

- Necesidad de definir mappings adecuados para visualizar correctamente los datos.
- Se convirtió el tipo de datos de coordenadas de `float` a `geo_point` mediante Logstash para permitir la visualización en mapas.
- Fue necesario usar `ruby` en logstash para poder obtener datos meteorológicos del día siguiente.
- La API no siempre devolvía datos precisos para coordenadas específicas, sino para ubicaciones cercanas.

### Metricbeat

- Inicialmente los índices generados por Metricbeat estaban ocultos, dificultando su inspección.
- Se encontró incompatibilidad en la configuración según la versión utilizada.

# Presentación
- La presentación se encuentra en formato .pdf en la carpeta `docs/` dentro del proyecto.
- La carpeta `docs/` contiene también la imagen de la arquitectura diseñada.
---

