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

<img width="922" height="483" alt="image" src="https://github.com/user-attachments/assets/8d142e7e-bfe6-429d-b50a-19782220db0b" />

Configuración y conexión serial: se inicia inicia definiendo los parámetros básicos de adquisición, entre ellos el puerto de comunicación, la velocidad de transmisión, la duración total de la captura y el tamaño de la ventana de visualización. Posteriormente, se establece la conexión serial con el dispositivo y se configura el terminador de línea, lo cual permite recibir correctamente cada muestra enviada por el sistema de adquisición. Esta etapa es fundamental porque garantiza la comunicación continua entre el sensor y MATLAB, requisito necesario para realizar un cálculo del SPI latido a latido durante un tiempo finito.

<img width="676" height="272" alt="image" src="https://github.com/user-attachments/assets/79a09dd3-e224-42c5-87b1-a0bbbac1cf0a" />

Inicialización de variables y preparación de la gráfica: Una vez establecida la comunicación, se crea los vectores donde se almacenan el tiempo, la señal PPG, los valores calculados de SPI y las variables auxiliares necesarias para el procesamiento. Además, se inicializa una figura en tiempo real mediante animatedline, en la cual se representa la señal adquirida y se reservan trazas adicionales para marcar visualmente los picos y los valles detectados. Esto permite supervisar simultáneamente la calidad de la adquisición y el funcionamiento del algoritmo de detección de máximos y mínimos.

<img width="808" height="536" alt="image" src="https://github.com/user-attachments/assets/22913f29-b9ee-45ac-8f5f-6b79239ea082" />

Adquisición de la señal PPG en tiempo real: Durante la ejecución principal, se lee continuamente los datos provenientes del puerto serial, convierte cada muestra a valor numérico y registra su instante de adquisición. A su vez, cada dato válido se añade a la señal completa y se representa de forma dinámica en pantalla. El código también invierte el signo de la muestra, con el fin de orientar la señal de manera conveniente para la detección de picos. De esta forma, se realiza una captura temporizada de la onda PPG mientras esta es visualizada en tiempo real.


<img width="751" height="326" alt="image" src="https://github.com/user-attachments/assets/39127590-621b-4592-ad42-d83ad3b7601e" />


Ventana deslizante y autoescala de la visualización: Con el propósito de mejorar la observación de la señal, se implementa una ventana deslizante de tiempo, mostrando únicamente el segmento más reciente de la adquisición. Asimismo, calcula automáticamente los límites verticales de la gráfica a partir del mínimo y máximo del tramo visible, añadiendo un pequeño margen para evitar que la señal quede recortada. Esta estrategia no modifica el contenido de la señal, pero sí facilita la inspección visual del comportamiento pulsátil y de la detección de eventos relevantes.

<img width="742" height="438" alt="image" src="https://github.com/user-attachments/assets/e3c324f2-b83c-4990-ae7f-376aa4c67643" />

Buffer de procesamiento y detección de máximos: Para procesar la señal latido a latido, se almacena las muestras recientes en un buffer. Cuando se dispone de suficientes datos, toma una ventana corta de análisis y calcula el intervalo temporal promedio entre muestras para estimar la separación mínima permitida entre picos. Después, utiliza la función findpeaks con dos criterios: una distancia mínima entre picos y una prominencia mínima adaptada a la variabilidad de la señal. Así, se reduce la probabilidad de detectar falsos máximos originados por ruido o pequeñas oscilaciones. Esta lógica es coherente con la idea general del algoritmo de detección de picos y valles descrito en la literatura consultada, donde la identificación de eventos válidos depende del comportamiento local de la onda y de condiciones adaptativas para evitar errores de detección.

<img width="766" height="431" alt="image" src="https://github.com/user-attachments/assets/a5edb9b0-2ab7-45cb-8d97-135f4755c53f" />

Evitar doble detección y cálculo del HBI: Cuando el algoritmo encuentra un pico, verifica que no se trate de una repetición del último evento detectado. Para ello compara el instante del nuevo pico con el del pico anterior y solo lo acepta si ha transcurrido un tiempo mínimo. Una vez validado, se calcula el HBI (heartbeat interval), definido como la diferencia temporal entre dos picos consecutivos. Este parámetro representa el intervalo entre latidos y constituye una de las variables empleadas posteriormente para estimar el SPI.

<img width="867" height="372" alt="image" src="https://github.com/user-attachments/assets/2e068d4b-4b97-4047-a352-5b5ed5454563" /> 

Detección de mínimos y cálculo de la PPGA: Después de localizar cada máximo, se busca el mínimo asociado dentro de un segmento previo de la señal. Para ello selecciona una pequeña región antes del pico y determina el menor valor contenido en ella, asumiendo que corresponde al valle del pulso. Con el máximo y el mínimo ya identificados, se calcula la PPGA (photoplethysmographic pulse wave amplitude) como la diferencia entre la amplitud del pico y la del valle consecutivo. Esta etapa responde directamente a lo solicitado por la guía, ya que implementa un algoritmo de detección de máximos y mínimos sobre la señal PPG. Además, coincide con la literatura de referencia, donde la detección de picos y valles se considera esencial para caracterizar adecuadamente cada pulso fotopletismográfico.

Normalización de HBI y PPGA: para el intervalo entre latidos. En el caso de la PPGA, se usa el promedio de los últimos valores almacenados; para el HBI, se utiliza el promedio de los intervalos entre picos detectados. Luego, ambos parámetros se expresan de manera relativa frente a sus respectivas referencias. Finalmente, sus valores se limitan superiormente para evitar que fluctuaciones extremas distorsionen el cálculo del índice. Este paso permite estabilizar la estimación del SPI y hacerla menos sensible a cambios abruptos aislados.

<img width="681" height="523" alt="image" src="https://github.com/user-attachments/assets/a228b482-e4fe-4eb0-9dd5-557d04911cd2" />

Cálculo y clasificación del SPI: Una vez obtenidos HBI_norm y PPGA_norm, se calcula el SPI mediante una combinación ponderada de ambas variables y restringe el resultado al intervalo de 0 a 100. Cada nuevo valor de SPI se almacena junto con su instante correspondiente, permitiendo construir posteriormente su evolución temporal. Además, se calcula la frecuencia cardíaca a partir del HBI y clasifica el valor del SPI en tres estados interpretativos: analgesia alta, rango óptimo o dolor. Finalmente, imprime en la ventana de comandos el tiempo, la frecuencia cardíaca, el valor de SPI y la categoría asociada.

<img width="763" height="513" alt="image" src="https://github.com/user-attachments/assets/807cab3b-8f9b-4af7-8d69-4d9cc280157c" />

Gráficas finales de señal PPG y SPI: Al finalizar la adquisición, se cierra la comunicación serial y genera dos gráficas finales: una correspondiente a la señal PPG completa adquirida y otra que muestra la evolución del SPI en función del tiempo.

Relación con el algoritmo de máximos y mínimos de la literatura: Aunque tu implementación usa findpeaks y una búsqueda local del valle, donde se describe un método de detección de picos y valles en señales PPG basado en el análisis de la forma de la onda y en criterios adaptativos. En ambos casos, el objetivo es identificar de manera confiable los máximos y mínimos de cada pulso para extraer parámetros como el intervalo entre latidos y la amplitud pico-valle, necesarios para el cálculo de índices derivados de la señal fotopletismográfica.

<img width="525" height="345" alt="image" src="https://github.com/user-attachments/assets/79535f44-313f-44af-8631-3e31ba718cc0" />




PARTE C







