# Laboratorio-C-lculo-ambulatorio-del-ndice-pletismogr-fico-quir-rgico-SPI-

PARTE A

Se construye en Protoboart el siguiente circuito mostrado en la figura 1. El cuál representa un sistema de fotopletismografía (PPG), técnica utilizada para medir las variaciones del volumen sanguíneo en el tejido periférico, generalmente en el dedo. Este tipo de medición es no invasiva y se basa en la interacción de la luz con el tejido biológico.

En la primera etapa del circuito se encuentra el sensor óptico, compuesto por un diodo emisor de luz (LED) y un fototransistor. El LED emite luz que atraviesa o se refleja en el tejido del dedo, mientras que el fototransistor detecta la cantidad de luz recibida. Debido a que el volumen de sangre en los vasos cambia con cada latido cardíaco, la cantidad de luz absorbida también varía. Estas variaciones generan una señal eléctrica proporcional a los cambios del flujo sanguíneo. Sin embargo, esta señal es muy débil y contiene tanto una componente continua (DC), asociada a las características estáticas del tejido, como una componente alterna (AC), asociada al pulso cardíaco.

Posteriormente, la señal pasa por una etapa de polarización y preamplificación, donde se utiliza un transistor (2N3904) para acondicionar la señal proveniente del sensor. Esta etapa permite adaptar la señal a niveles adecuados para su procesamiento posterior, mejorando su estabilidad y reduciendo efectos no deseados.

A continuación, se implementa un filtro pasa altas (HPF) formado por un capacitor de 4.7 µF y una resistencia de 47 kΩ, con una frecuencia de corte aproximada de 0.7 Hz. La función principal de este filtro es eliminar la componente DC de la señal, es decir, las variaciones lentas o constantes debidas a la iluminación ambiental, la piel y otros factores estáticos. De esta manera, se preserva únicamente la componente pulsátil relacionada con los latidos del corazón.

Después del filtrado pasa altas, la señal ingresa a un filtro pasa bajas activo (LPF) basado en un amplificador operacional. Este filtro tiene una frecuencia de corte de aproximadamente 2.34 Hz y una ganancia cercana a 101. Su propósito es doble: por un lado, elimina el ruido de alta frecuencia, como interferencias eléctricas o artefactos por movimiento; por otro, amplifica la señal útil para hacerla más visible y procle. Este rango de frecuencias es adecuado, ya que la frecuencia cardíaca humana típicamente se encuentra entre 0.8 Hz y 2 Hz aproximadamente 50 a 120 latidos por minuto.

El circuito incluye además un potenciómetro que permite ajustar la ganancia de la señal, facilitando la calibración dependiendo del usuario o de las condiciones de medición. Esto es importante porque la amplitud de la señal PPG puede variar significativamente entre personas.

Finalmente, la señal pasa por una etapa adicional de amplificación y ajuste de offset, utilizando otro amplificador operacional y un potenciómetro. Esta etapa permite centrar la señal y escalarla adecuadamente para su visualización o adquisición mediante un sistema externo, como un microcontrolador ESP32. La salida final 𝑉𝑜𝑢𝑡 es una señal PPG limpia, amplificada y lista para análisis.

En conjunto, este circuito permite obtener una señal representativa del pulso cardíaco, la cual es utilizada para calcular parámetros fisiológicos como la frecuencia cardíaca, los intervalos entre latidos (RR), y el índice pletismográfico quirúrgico (SPI). La correcta implementación de las etapas de filtrado y amplificación es fundamental para garantizar una señal confiable y libre de ruido.

<img width="1102" height="621" alt="image" src="https://github.com/user-attachments/assets/efdcdfa7-7297-4dfe-9a8a-8a36a17451b0" />

Como se está usando un acoplador óptico TCST110, se modifica tal y como se ilustra en la Figura 2 para convertirlo en un sensor de reflectancia, debido a que el emisor de luz (LED infrarrojo) y el fotodetector se encuentran ubicados en el mismo lado del tejido. En esta configuración, la luz emitida penetra el tejido biológico y una fracción de ella es reflejada de regreso hacia el detector. Las variaciones en el volumen sanguíneo modifican la cantidad de luz reflejada, permitiendo obtener una señal fotopletismográfica. La presencia de una barrera central asegura que la detección se base en la luz reflejada y no en el acoplamiento directo entre el emisor y el receptor.

<img width="712" height="402" alt="image" src="https://github.com/user-attachments/assets/8706c417-241c-4cb8-820d-9d6bef627890" />

Se conecto el circuito a una de las entradas analógicas de una placa de adquisición. En este caso, se utilizó un microcontrolador ESP32 para la lectura de la señal, empleando sus entradas analógicas y herramientas de visualización en tiempo real.

Se intentó verificar el funcionamiento del sistema mediante la visualización de la señal adquirida, con el objetivo de observar las variaciones del volumen sanguíneo periférico propias de la señal fotopletismográfica (PPG). Sin embargo, durante la implementación del circuito analógico se presentaron dificultades para obtener una señal estable y libre de ruido. Estas dificultades pueden atribuirse a factores como la sensibilidad del sensor óptico a la luz ambiente, el acoplamiento incorrecto del sensor con el tejido, limitaciones en el ajuste de ganancia mediante los potenciómetros, y problemas en el control del nivel de offset, el cual en algunos casos requiere el uso de una fuente negativa por ejemplo, VEE = -3 V.

A pesar de realizar múltiples ajustes en el circuito, no fue posible obtener una señal confiable para su posterior procesamiento.

Debido a estas limitaciones, se optó por utilizar un sensor comercial integrado tipo MAX30102, el cual incorpora internamente el emisor de luz, el fotodetector y las etapas de acondicionamiento de señal. Este sensor permite obtener señales fotopletismográficas con mayor estabilidad, reduciendo significativamente la interferencia y el ruido.

El sensor fue conectado al microcontrolador ESP32, permitiendo la adquisición y visualización de la señal en tiempo real. Posteriormente, dicha señal fue utilizada para el análisis y procesamiento.

<img width="896" height="342" alt="image" src="https://github.com/user-attachments/assets/a0221264-1903-49b0-847b-9a7370f7dad3" />

COLD PRESSOR TEST (CPT)

El Cold Pressor Test (CPT) es una técnica utilizada en fisiología cardiovascular para evaluar la respuesta del sistema nervioso autónomo ante un estímulo de frío. Tradicionalmente, consiste en la inmersión de la mano en agua entre 0 y 5 °C durante 1 a 3 minutos, lo que provoca una activación del sistema nervioso simpático, generando vasoconstricción periférica, aumento de la presión arterial y cambios en la frecuencia cardíaca.

En este laboratorio, debido a limitaciones prácticas, se utilizó una adaptación del método mediante compresas previamente enfriadas en un congelador, las cuales se colocaron sobre el antebrazo del sujeto. Durante el procedimiento se registró la señal fotopletismográfica (PPG) en tres fases: basal, aplicación del estímulo frío y recuperación, permitiendo observar las variaciones del volumen sanguíneo periférico ante el estímulo.

PARTE B 

El índice pletismográfico quirúrgico (SPI, Surgical Pleth Index) es un parámetro numérico empleado para estimar el balance entre nocicepción y analgesia a partir de la señal fotopletismográfica (PPG). Este índice toma valores entre 0 y 100, donde los valores más altos se asocian con una mayor respuesta nociceptiva o de estrés, y durante anestesia general suele considerarse como rango adecuado de analgesia el intervalo entre 20 y 50. La práctica se enfoca en la extracción y cálculo de características derivadas de la onda de pulso para estimar dicho balance autonómico.

Para calcular el SPI latido a latido, se implementa un algoritmo de detección de máximos y mínimos sobre la señal adquirida. Como base para esta etapa se tomó de la literatura el “método del alpinista” (Mountaineer’s Method for Peak Detection, MMPD), el cual permite detectar picos sistólicos en tiempo real a partir del cambio de pendiente de la señal: durante la fase ascendente de la onda, el algoritmo cuenta el número de incrementos consecutivos y, cuando la pendiente cambia de positiva a negativa y se supera un umbral adaptativo, se identifica un máximo. A su vez, el algoritmo también registra el valle que precede a cada pico, lo que permite conformar el par pico-valle de cada pulso.

La detección correcta de este par máximo-mínimo es fundamental, ya que la amplitud pletismográfica de pulso (PPGA) se obtiene como la diferencia entre la amplitud del pico y la del valle consecutivo. Por ello, contar con un algoritmo que detecte de forma consistente ambos puntos de cada latido resulta indispensable para el cálculo confiable de parámetros derivados de la señal PPG, como el SPI. En este contexto, el método del alpinista constituye una estrategia adecuada para la práctica, debido a que fue diseñado para operar en tiempo real y mostrar un buen desempeño incluso cuando la amplitud de la señal disminuye.


PARTE C







