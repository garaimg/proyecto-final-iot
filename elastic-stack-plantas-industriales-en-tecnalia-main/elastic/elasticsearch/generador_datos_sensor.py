import random
import time


def generar_datos_sensor():
    humedad = random.uniform(0, 100)  # Porcentaje de humedad en la planta industrial
    temperatura = random.uniform(8, 30)  # Rango típico en una planta industrial enºC
    luminosidad = random.uniform(100, 1000)  # Rango típico de una planta industrial en lx
    presion_atm = random.uniform(900, 1100)  # Rango típico de presión atmosférica en hPa
    fecha_obtencion = time.strftime("%Y-%m-%d %H:%M:%S")  # Fecha de obtención de los datos

    return {
        "humedad": humedad,
        "temperatura": temperatura,
        "luminosidad": luminosidad,
        "presion_atm": presion_atm,
        "fecha_obtencion": fecha_obtencion
    }


if __name__ == "__main__":
    while True:
        datos_sensor = generar_datos_sensor()
        print(datos_sensor)
        time.sleep(5)
