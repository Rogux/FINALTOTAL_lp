# Informe: Funcionamiento de los algoritmos de búsqueda de patrones

Este README.md proporciona una explicación detallada sobre el funcionamiento de los algoritmos de búsqueda de patrones: Fuerza Bruta, Knuth-Morris-Pratt (KMP) y Boyer-Moore.

## Fuerza Bruta

El algoritmo de Fuerza Bruta compara el patrón con cada subcadena posible del texto de manera secuencial. A continuación se muestra el procedimiento básico:

- Comparar el primer carácter del patrón con el primer carácter de la subcadena del texto.
- Si hay una coincidencia, continuar comparando los caracteres siguientes uno por uno.
- Si todos los caracteres coinciden, se ha encontrado una coincidencia del patrón en el texto.
- Si hay una discrepancia en algún punto, avanzar al siguiente carácter de la subcadena del texto y repetir el proceso.

La complejidad de tiempo de Fuerza Bruta es O(n * m), donde n es la longitud del texto y m es la longitud del patrón.

## Knuth-Morris-Pratt (KMP)

El algoritmo KMP utiliza una tabla de fallos precalculada para evitar comparaciones redundantes. A continuación se muestra el funcionamiento básico:

- Construir una tabla de fallos, llamada tabla de bordes, para el patrón.
- Utilizando la tabla de bordes, comparar el patrón con el texto carácter por carácter.
- Si hay una discrepancia, utilizar la información de la tabla de bordes para determinar el siguiente desplazamiento óptimo sin retroceder en la subcadena del texto ya comparada.
- Repetir el proceso hasta encontrar una coincidencia o agotar todas las combinaciones.

La complejidad de tiempo de KMP es O(n + m), donde n es la longitud del texto y m es la longitud del patrón.

## Boyer-Moore

El algoritmo Boyer-Moore examina el texto de derecha a izquierda y utiliza información heurística para saltar posiciones durante la búsqueda. A continuación se muestra el funcionamiento básico:

- Preprocesar el patrón y construir dos tablas: la tabla de saltos malos y la tabla de saltos buenos.
- Comenzar la búsqueda del patrón desde el final del texto.
- Comparar los caracteres del patrón con los del texto de derecha a izquierda.
- Si hay una discrepancia, utilizar las tablas de saltos para determinar el desplazamiento óptimo basado en las reglas heurísticas.
- Repetir el proceso hasta encontrar una coincidencia o agotar todas las combinaciones.

La complejidad de tiempo promedio de Boyer-Moore es O(n/m), donde n es la longitud del texto y m es la longitud del patrón.

## Conclusiones

- Fuerza Bruta es simple pero ineficiente para textos largos o patrones complejos.
- KMP mejora la eficiencia de búsqueda utilizando la tabla de bordes.
- Boyer-Moore es aún más eficiente al utilizar información heurística y realizar saltos en el texto durante la búsqueda.

En general, la elección del algoritmo dependerá del tamaño del texto, la longitud del patrón y las características específicas del problema.

