if (!require('sf')) install.packages('sf'); library('sf')

#bajar mapas mexico
# 
urltot<-"https://www.inegi.org.mx/contenidos/productos/prod_serv/contenidos/espanol/bvinegi/productos/geografia/marcogeo/889463849568/mg2021_integrado.zip"

temp <- tempdir()
getOption('timeout')
options(timeout=500)
download.file(urltot, "temporal.zip")
#Expandir archivo zip en otro directorio
unzip("temporal.zip", exdir="temp")
mapamex <-st_read("temp/conjunto_de_datos/00ent.shp")

#Borrar archivos que se bajaron en caso de solamente
#querer los estados
# Se puede conservar el archivo si se quiere trabajar a otra escala
unlink("temp", recursive = T)
unlink("temporal.zip")

