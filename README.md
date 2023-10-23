# Mapademexico
Manual básico para la elaboración de mapas de México a nivel estatal en R con el paquete tmap. Un tutorial muy informal de como elaborar mapas
vectoriales en R con la librería tmap, incluyendo instrucciones de cómo obtener los datos geográficos de INEGI, bajarlos y convertirlos a un
objeto de R.

Los archivos incluídos en este repositorio son los siguientes:

- Archivo mapasmex.pdf: pequeño manual informal para elaborar mapas basados en vectores de México a nivel estado, como añadir datos geoespaciales
y distintas formas de graficar los datos a nivel estatal en los mapas. Incluye instrucciones para bajar los datos georreferenciados de la página
de INEGI.
- mexico.R Código R para bajar la información de INEGI y crear un objeto en R.
- shapes_intro.R  Código para introducir conceptos de objetos geométricos clase sf.
- mapamx.R Código R para simplificar el objeto sf, crear mapas, añadir y graficar datos, de la forma explicada en mapasmex.pdf
- mapamex_simple. RData objeto sf de datos georreferenciados de los estados de México, simplificado.
- mapamex_data.RData Igual que mapamex_simple.RData pero con datos falsos generados por computadora para graficar ejemplos. Cómo se generaron
estos datos y este mapa se explica en el archivo pdf y en mapamx.R

Hay que tener cuidado de no cargar los dos archivos RData, dado que el objeto sf con y sin los datos extra se llama igual en ambos archivos.
