# Preguntas

## ¿Qué crítica le harías al protocolo de #estaHerido y #noEstaHerido? (en vez de tener solo el mensaje #estaHerido y hacer “#estaHerido not” para saber la negación)

Al tener estos dos, si bien no tengo exactamente código repetido, se podría haber resumido en un único mensaje, dado que uno es el opuesto del otro, lo cual hubiese ayudado a la variabilidad del código a futuro, y a mantener el conjunto de mensajes minimal.

## ¿Qué opinan de que para algunas funcionalidades tenemos 3 tests para el mismo comportamiento pero aplicando a cada uno de los combatientes (Arthas, Mankrik y Olgra)?

Consideramos que fue útil a la hora de ir desarrollando a los distintos combatientes mientras no sabíamos que, por ejemplo, el humano y los orcos iban a tener exactamente las mismas funcionalidades: mismos mensajes con mismos métodos. De haber sabido desde un principio que todos hacían lo mismo, se podría haber modelado a un único combatiente, y luego crear el resto como hijos de este primero, y en ese caso, estos tests serían redundantes. En el estado actual del modelo, se podría probar ya para uno solo.

## ¿Cómo modelaron el resultado de haber desarrollado un combate? ¿qué opciones consideraron y por qué se quedaron con la que entregaron y por qué descartaron a las otras?

Decidimos que el orquestador pueda responder a los mensajes de ganador, rondasEjecutadas y un último que dice si hubo o no ganador. En el resultado se guarda al orquestador mismo, y mediante estos mensajes se puede acceder a los colaboradores internos del orquestador sin romper el encapsulamiento. En ganador se guarda un número que representa al número del bando ganador, pero como no es tan claro que que el ganador sea 0 significa que no ganó nadie, se creó el último que dice si hubo ganador.

Se consideró también la opción de que el mensaje que desarrolla el combate devuelva únicamente el número del bando ganador, y que la cantidad de rondas ejecutadas se las pidan directamente al orquestador de combates, pero nos parecía que estaba nuevamente el problema de que no se sabía que 0 significaba que no ganó nadie, y tomar las stats de dos lugares distintos parecía un tanto rebuscado.

Por último, se consideró que el resultado almacene una dupla #(ganador, rondasEjecutadas), pero no solo estaba el problema 0 sino que a su vez no sabíamos cómo podría saber en qué posición iba cual. Por un tema de claridad, y de lo ya dicho anteriormente, se terminó eligiendo la primera opción.
