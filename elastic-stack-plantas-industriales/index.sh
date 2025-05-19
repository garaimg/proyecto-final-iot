#!/bin/sh

echo "Executing index.sh"

# elasticsearch URL
ELASTICSEARCH_URL="http://elasticsearch:9200"

# Nombre del índice
INDEX_NAME="datos_sedes_sensor_index"

INDEX2_NAME="datos_meteorologicos_actuales_sedes_index"

INDEX3_NAME="datos_meteorologicos_dia_siguiente_sedes_index"


# Mapping del indice
MAPPING_datos_sedes_sensor_index='{
    "mappings": {
        "properties": {
            "sede_info": {
                "properties": {
                    "nombre": {"type": "keyword"},
                    "coordenadas": {"type": "geo_point"}
                }
            },
            "sensor_datos": {
                "properties": {
                    "humedad": {"type": "float"},
                    "temperatura": {"type": "float"},
                    "luminosidad": {"type": "float"},
                    "presion_atm": {"type": "float"},
                    "fecha_obtencion": {"type": "date", "format": "yyyy-MM-dd HH:mm:ss"}
                }
            }
        }
    }
}'

MAPPING_datos_meteorologicos_actuales_sedes_index='{
  "mappings": {
    "properties": {
      "@timestamp": {
        "type": "date"
      },
      "sede_info_nombre": {
        "type": "text",
        "fields": {
          "keyword": {
          "type": "keyword",
          "ignore_above": 256
          }
        }
      },
      "@version": {
        "type": "text",
        "fields": {
          "keyword": {
            "type": "keyword",
            "ignore_above": 256
          }
        }
      },
      "current": {
        "properties": {
          "apparent_temperature": {
            "type": "float"
          },
          "interval": {
            "type": "long"
          },
          "precipitation": {
            "type": "float"
          },
          "relative_humidity_2m": {
            "type": "long"
          },
          "temperature_2m": {
            "type": "float"
          },
          "time": {
            "type": "date"
          },
          "wind_speed_10m": {
            "type": "float"
          }
        }
      },
      "current_units": {
        "properties": {
          "apparent_temperature": {
            "type": "text",
            "fields": {
              "keyword": {
                "type": "keyword",
                "ignore_above": 256
              }
            }
          },
          "interval": {
            "type": "text",
            "fields": {
              "keyword": {
                "type": "keyword",
                "ignore_above": 256
              }
            }
          },
          "precipitation": {
            "type": "text",
            "fields": {
              "keyword": {
                "type": "keyword",
                "ignore_above": 256
              }
            }
          },
          "relative_humidity_2m": {
            "type": "text",
            "fields": {
              "keyword": {
                "type": "keyword",
                "ignore_above": 256
              }
            }
          },
          "temperature_2m": {
            "type": "text",
            "fields": {
              "keyword": {
                "type": "keyword",
                "ignore_above": 256
              }
            }
          },
          "time": {
            "type": "text",
            "fields": {
              "keyword": {
                "type": "keyword",
                "ignore_above": 256
              }
            }
          },
          "wind_speed_10m": {
            "type": "text",
            "fields": {
              "keyword": {
                "type": "keyword",
                "ignore_above": 256
              }
            }
          }
        }
      },
      "elevation": {
        "type": "float"
      },
      "event": {
        "properties": {
          "original": {
            "type": "text",
            "fields": {
              "keyword": {
                "type": "keyword",
                "ignore_above": 256
              }
            }
          }
        }
      },
      "generationtime_ms": {
        "type": "float"
      },
      "latitude": {
        "type": "float"
      },
      "location": {
        "type": "geo_point"
      },
      "longitude": {
        "type": "float"
      },
      "tags": {
        "type": "text",
        "fields": {
          "keyword": {
            "type": "keyword",
            "ignore_above": 256
          }
        }
      },
      "timezone": {
        "type": "text",
        "fields": {
          "keyword": {
            "type": "keyword",
            "ignore_above": 256
          }
        }
      },
      "timezone_abbreviation": {
        "type": "text",
        "fields": {
          "keyword": {
            "type": "keyword",
            "ignore_above": 256
          }
        }
      },
      "utc_offset_seconds": {
        "type": "long"
      }
    }
  }
}'
MAPPING_datos_meteorologicos_dia_siguiente_sedes_index='{
  "mappings": {
    "properties": {
      "@timestamp": {
        "type": "date"
      },
      "sede_info_nombre": {
        "type": "text",
        "fields": {
          "keyword": {
          "type": "keyword",
          "ignore_above": 256
          }
        }
      },
      "@version": {
        "type": "text",
        "fields": {
          "keyword": {
            "type": "keyword",
            "ignore_above": 256
          }
        }
      },
      "daily": {
        "properties": {
          "apparent_temperature_max": {
            "type": "float"
          },
          "apparent_temperature_min": {
            "type": "float"
          },
          "daylight_duration": {
            "type": "float"
          },
          "precipitation_probability_max": {
            "type": "long"
          },
          "precipitation_sum": {
            "type": "float"
          },
          "temperature_2m_max": {
            "type": "float"
          },
          "temperature_2m_min": {
            "type": "float"
          },
          "time": {
            "type": "date"
          },
          "weather_code": {
            "type": "long"
          },
          "wind_direction_10m_dominant": {
            "type": "long"
          },
          "wind_speed_10m_max": {
            "type": "float"
          }
        }
      },
      "daily_units": {
        "properties": {
          "apparent_temperature_max": {
            "type": "text",
            "fields": {
              "keyword": {
                "type": "keyword",
                "ignore_above": 256
              }
            }
          },
          "apparent_temperature_min": {
            "type": "text",
            "fields": {
              "keyword": {
                "type": "keyword",
                "ignore_above": 256
              }
            }
          },
          "daylight_duration": {
            "type": "text",
            "fields": {
              "keyword": {
                "type": "keyword",
                "ignore_above": 256
              }
            }
          },
          "precipitation_probability_max": {
            "type": "text",
            "fields": {
              "keyword": {
                "type": "keyword",
                "ignore_above": 256
              }
            }
          },
          "precipitation_sum": {
            "type": "text",
            "fields": {
              "keyword": {
                "type": "keyword",
                "ignore_above": 256
              }
            }
          },
          "temperature_2m_max": {
            "type": "text",
            "fields": {
              "keyword": {
                "type": "keyword",
                "ignore_above": 256
              }
            }
          },
          "temperature_2m_min": {
            "type": "text",
            "fields": {
              "keyword": {
                "type": "keyword",
                "ignore_above": 256
              }
            }
          },
          "time": {
            "type": "text",
            "fields": {
              "keyword": {
                "type": "keyword",
                "ignore_above": 256
              }
            }
          },
          "weather_code": {
            "type": "text",
            "fields": {
              "keyword": {
                "type": "keyword",
                "ignore_above": 256
              }
            }
          },
          "wind_direction_10m_dominant": {
            "type": "text",
            "fields": {
              "keyword": {
                "type": "keyword",
                "ignore_above": 256
              }
            }
          },
          "wind_speed_10m_max": {
            "type": "text",
            "fields": {
              "keyword": {
                "type": "keyword",
                "ignore_above": 256
              }
            }
          }
        }
      },
      "elevation": {
        "type": "float"
      },
      "event": {
        "properties": {
          "original": {
            "type": "text",
            "fields": {
              "keyword": {
                "type": "keyword",
                "ignore_above": 256
              }
            }
          }
        }
      },
      "generationtime_ms": {
        "type": "float"
      },
      "latitude": {
        "type": "float"
      },
      "longitude": {
        "type": "float"
      },
      "timezone": {
        "type": "text",
        "fields": {
          "keyword": {
            "type": "keyword",
            "ignore_above": 256
          }
        }
      },
      "timezone_abbreviation": {
        "type": "text",
        "fields": {
          "keyword": {
            "type": "keyword",
            "ignore_above": 256
          }
        }
      },
      "utc_offset_seconds": {
        "type": "long"
      }
    }
  }
}'
if curl -f -X PUT "${ELASTICSEARCH_URL}/${INDEX_NAME}" -H 'Content-Type: application/json' -d "${MAPPING_datos_sedes_sensor_index}"; then
    echo "Índice ${INDEX_NAME} creado con éxito."
    curl -X PUT "${ELASTICSEARCH_URL}/${INDEX_NAME}/_settings" -H 'Content-Type: application/json' -d '{
      "index": {
        "number_of_replicas": 0
      }
    }'
else
    echo "Error al crear el índice ${INDEX_NAME}."
fi
if curl -f -X PUT "${ELASTICSEARCH_URL}/${INDEX2_NAME}" -H 'Content-Type: application/json' -d "${MAPPING_datos_meteorologicos_actuales_sedes_index}"; then
    echo "Índice ${INDEX2_NAME} creado con éxito."
    curl -X PUT "${ELASTICSEARCH_URL}/${INDEX2_NAME}/_settings" -H 'Content-Type: application/json' -d '{
      "index": {
        "number_of_replicas": 0
      }
    }'
else
    echo "Error al crear el índice ${INDEX2_NAME}."
fi
if curl -f -X PUT "${ELASTICSEARCH_URL}/${INDEX3_NAME}" -H 'Content-Type: application/json' -d "${MAPPING_datos_meteorologicos_dia_siguiente_sedes_index}"; then
    echo "Índice ${INDEX3_NAME} creado con éxito."
    curl -X PUT "${ELASTICSEARCH_URL}/${INDEX3_NAME}/_settings" -H 'Content-Type: application/json' -d '{
      "index": {
        "number_of_replicas": 0
      }
    }'
else
    echo "Error al crear el índice ${INDEX3_NAME}."
    exit 1
fi