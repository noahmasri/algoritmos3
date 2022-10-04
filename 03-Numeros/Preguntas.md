###Preguntas teóricas

####Aporte de los mensajes de DD

#####En un double dispatch (DD), ¿qué información aporta cada uno de los dos llamados?

El primer llamado aporta información sobre el receptor, sobre su clase. En cambio, el segundo llamado nos da información sobre la clase del parámetro, y decide cómo se lleva a cabo la interacción entre estos dos, dejando que la responsabilidad de finalmente responder al mensaje recaiga en quien corresponda según tenga sentido en el dominio. 

####Lógica de instanciado

#####Con lo que vieron y saben hasta ahora, ¿donde les parece mejor tener la lógica de cómo instanciar un objeto? ¿por qué? ¿Y si se crea ese objeto desde diferentes lugares y de diferentes formas? ¿cómo lo resuelven?

En el caso del trabajo, dada la similitud entre las subclases de Entero, nos parece más lógico implementar la instanciación de los objetos como mensaje de clase de esta, y que a partir de esto se decida cual subclase deberá instanciar. A su vez aquí, a través de las diversas operaciones, puede llegar una instancia de una clase a convertirse en instancia de otra. En otros casos en que las subclases no son tan similares, quizás convenga ya hacer las instancias desde las hojas, desde ya las clases concretas. 

Si un objeto se puede crear desde distintos lugares y de distintas formas, quizás sea conveniente ir delegando responsabilidades, haciendo que dependiendo de el o los parámetros se pueda decidir cómo instanciar (switch dinámico).

####Nombres de las categorías de métodos

#####Con lo que vieron y trabajaron hasta ahora, ¿qué criterio están usando para categorizar métodos?

El criterio que estamos usando para categorizar los métodos es por la funcionalidad de los mensajes. A su vez, se agregan categorías privadas en donde no se explicita necesariamente la funcionalidad sino que advierte al usuario que estos no deberían ser usados directamente por el.

####Subclass Responsibility

#####Si todas las subclases saben responder un mismo mensaje, ¿por qué ponemos ese mensaje sólo con un “self subclassResponsibility” en la superclase? ¿para qué sirve?

Si bien no es estrictamente necesario hacerlo, pues sin el “self subclassResponsibility” nuestro programa puede funcionar correctamente, esto es considerado una buena práctica ya que si se quisiera agregar una nueva subclase y se nos olvidase implementar alguno de los mensajes, el error que arroja el debugger es mucho más claro: es responsabilidad de la subclase implementar el método para dicho mensaje (subclass should have overridden). 

####No rompas

#####¿Por qué está mal/qué problemas trae romper encapsulamiento?

Romper el encapsulamiento trae problemas con la sostenibilidad del código y dificulta su expansibilidad. En muchos casos lleva a que objetos que en mi dominio no deberían conocerse terminen relacionándose y generando así un fuerte acoplamiento.   