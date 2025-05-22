
# Elastic Stack - Plantas Industriales en Tecnalia

## Descripción del Proyecto

Este proyecto simula un entorno industrial distribuido con múltiples plantas en distintas localizaciones. Se generan datos de sensores (temperatura, humedad, luminosidad, presión, etc.) que se envían a Elasticsearch para su análisis y visualización en tiempo real mediante Kibana. Además, se integran datos meteorológicos de fuentes externas para enriquecer la información de cada sede.

## Miembros del Equipo

- Markel Aguirre  
- Garai Martínez de Santos  
- Pablo Ruiz de Azúa  

## Tecnologías Utilizadas

- **Python**: Simulación de datos de sensores y envío a Elasticsearch.
- **Elasticsearch**: Almacenamiento de los datos de sensores y meteorológicos.
- **Kibana**: Visualización de los datos a través de dashboards interactivos.
- **Logstash**: Captura de datos meteorológicos desde una API externa utilizando el plugin `http_poller`.
- **Metricbeat**: Monitorización de los recursos del sistema y contenedores Docker.
- **Docker & Docker Compose**: Orquestación y despliegue de todos los servicios del proyecto.

## Estructura de los Módulos

### 1. Simulador de Datos de Sensores

Genera datos aleatorios para cada sede industrial cada 20 segundos, emulando sensores físicos.

### 2. Envío de Datos a Elasticsearch

Los datos generados por el simulador se indexan directamente en Elasticsearch.

### 3. Dockerización del Simulador

Incluye un Dockerfile que ejecuta automáticamente el script de simulación en su contenedor.

### 4. Captura de Datos Meteorológicos

Logstash se encarga de recoger datos desde una API meteorológica usando pipelines configurados con `http_poller`.

### 5. Visualización de Datos

Kibana permite explorar y analizar todos los datos a través de dashboards configurados.

### 6. Monitorización del Sistema

Metricbeat se encarga de reportar métricas del sistema y contenedores activos al stack.

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
---

