# Laboratorio-C-lculo-ambulatorio-del-ndice-pletismogr-fico-quir-rgico-SPI-

PARTE A

Se construye en Protoboart el siguiente circuito mostrado en la figura 1. El cuál representa un sistema de fotopletismografía (PPG), técnica ampliamente utilizada en ingeniería biomédica para medir las variaciones del volumen sanguíneo en el tejido periférico, generalmente en el dedo. Este tipo de medición es no invasiva y se basa en la interacción de la luz con el tejido biológico.

En la primera etapa del circuito se encuentra el sensor óptico, compuesto por un diodo emisor de luz (LED) y un fototransistor. El LED emite luz que atraviesa o se refleja en el tejido del dedo, mientras que el fototransistor detecta la cantidad de luz recibida. Debido a que el volumen de sangre en los vasos cambia con cada latido cardíaco, la cantidad de luz absorbida también varía. Estas variaciones generan una señal eléctrica proporcional a los cambios del flujo sanguíneo. Sin embargo, esta señal es muy débil y contiene tanto una componente continua (DC), asociada a las características estáticas del tejido, como una componente alterna (AC), asociada al pulso cardíaco.

Posteriormente, la señal pasa por una etapa de polarización y preamplificación, donde se utiliza un transistor (2N3904) para acondicionar la señal proveniente del sensor. Esta etapa permite adaptar la señal a niveles adecuados para su procesamiento posterior, mejorando su estabilidad y reduciendo efectos no deseados.

A continuación, se implementa un filtro pasa altas (HPF) formado por un capacitor de 4.7 µF y una resistencia de 47 kΩ, con una frecuencia de corte aproximada de 0.7 Hz. La función principal de este filtro es eliminar la componente DC de la señal, es decir, las variaciones lentas o constantes debidas a la iluminación ambiental, la piel y otros factores estáticos. De esta manera, se preserva únicamente la componente pulsátil relacionada con los latidos del corazón.

Después del filtrado pasa altas, la señal ingresa a un filtro pasa bajas activo (LPF) basado en un amplificador operacional. Este filtro tiene una frecuencia de corte de aproximadamente 2.34 Hz y una ganancia cercana a 101. Su propósito es doble: por un lado, elimina el ruido de alta frecuencia, como interferencias eléctricas o artefactos por movimiento; por otro, amplifica la señal útil para hacerla más visible y procesable. Este rango de frecuencias es adecuado, ya que la frecuencia cardíaca humana típicamente se encuentra entre 0.8 Hz y 2 Hz aproximadamente 50 a 120 latidos por minuto.

El circuito incluye además un potenciómetro que permite ajustar la ganancia de la señal, facilitando la calibración dependiendo del usuario o de las condiciones de medición. Esto es importante porque la amplitud de la señal PPG puede variar significativamente entre personas.

Finalmente, la señal pasa por una etapa adicional de amplificación y ajuste de offset, utilizando otro amplificador operacional y un potenciómetro. Esta etapa permite centrar la señal y escalarla adecuadamente para su visualización o adquisición mediante un sistema externo, como un microcontrolador ESP32. La salida final 𝑉𝑜𝑢𝑡 es una señal PPG limpia, amplificada y lista para análisis.

En conjunto, este circuito permite obtener una señal representativa del pulso cardíaco, la cual es utilizada para calcular parámetros fisiológicos como la frecuencia cardíaca, los intervalos entre latidos (RR), y el índice pletismográfico quirúrgico (SPI). La correcta implementación de las etapas de filtrado y amplificación es fundamental para garantizar una señal confiable y libre de ruido.

<img width="1102" height="621" alt="image" src="https://github.com/user-attachments/assets/efdcdfa7-7297-4dfe-9a8a-8a36a17451b0" />




