##### ###########################
#### Código para generar mapas de México como se explica en el instructivo
#### llamado Mapaspex.pdf



#Librerías usadas en este código.
# Las librerías se instalan con la función install.packages("paquete")
# donde paquete es el nombre de la librería.
library(tidyverse)
library(sf)
library(tmap)
library(rmapshaper)
library(RColorBrewer)

#Simplificar mapa
mex_simple <- st_simplify(mapamex, dTolerance=2000)

#Simplificar mapa con rmapshaper
    
mapamex_simple <-  ms_simplify(mapamex, keep = 0.01, keep_shapes = TRUE)
mapamex_muysimple <- ms_simplify(mapamex, keep = 0.002, keep_shapes = TRUE)

#graficar mapas simplificado
mex_simple %>%
    tm_shape(mapamex_simple) +
    tm_borders()

mapamex_simple %>% tm_shape() +
                  tm_borders() +
                  tm_layout(title = "Simplificado",
                            title.position = c('center', 'top'))
    
             
mapamex_muysimple %>% tm_shape() +
    tm_borders() +
    tm_layout(title = "Muy simplificado",
              title.position = c('center', 'top'))



## Graficar mapa. Usar mapamex_simple.

#Para ejemplificar como graficar datos en el mapa, creamos dos columnas de datos 
#inventados, una categórica y una numérica.
set.seed(100)
categorica <- sample(c("gato", "perro", "conejo"), 32, replace = T)
numerica <- round(runif(32,30,80),2)
numerica2 <- round(rnorm(32, 40, 40))^2

# Añadir los datos al objeto sf

#Con dplyr

mapamex_simple <-
    mapamex_simple %>% 
    mutate(categorica = categorica, 
    numerica = numerica,
    numerica2 = numerica2)

# Se pueden añadir con R base


# mapamex_simple <- cbind(mapamex_simple, categorica, numerica)
#
# mapamex_simple$numerica <- numerica
# mapamex_simple$categorica  <- categorica


# Mapa básico. Solamente las fronteras de los estados.

tm_shape(mex_simple) +
    tm_borders()

# Mapa graficando variable categórica. Cada estado se ilumina con un color distinto.


tm_shape(mapamex_simple) +
    tm_borders() +
    tm_fill("categorica"   #nombre de la variable
            , style = "cat") #tipod e variable

# Lo mismo. tm_polygons() es equivalente a tm_borders() + tm_fill()

tm_shape(mapamex_simple) +
    tm_polygons("categorica", style = "cat")

#  Mapa graficando variable numérica. Default.


tm_shape(mapamex_simple) +
    tm_borders() +
    tm_fill(col ="numerica",  title="Mexico")

#Mapa con variable numérica con rango dividido en intervalos de misma longitud.


tm_shape(mapamex_simple) +
    tm_fill("numerica",   style ="equal") +
    tm_borders()


#Mapa con variable numérica con rango dividido en intervalos con mismo número
# de observaciones

  
tm_shape(mapamex_simple) +
    tm_fill("numerica",   style ="quantile") +
    tm_borders()


# Lo mismo que el anterior pero especifidando manualmente el número de intervalos

  
tm_shape(mapamex_simple) +
    tm_borders() +
    tm_fill("numerica", #nombre de variable
            style= "equal", #rango dividido en intervalos iguales
            n=7)            #número de intervalos



# Mapa con variable contínua

  
tm_shape(mapamex_simple) +
    tm_borders() +
    tm_fill("numerica", style= "cont") 


## Usar otros colores
 

#especificar paleta con RColorBrewer

# Mostrar todas las paletas

display.brewer.all()

#Especificar paleta y asignarla a un objeto
mypal <- brewer.pal(5,"GnBu")

#Graficar mapa usando paleta creada anteriormente
  
tm_shape(mapamex_simple) +
    tm_borders() +
    tm_fill("numerica",  
            style = "equal",
            #Pasar argumento con paleta que queremos usar
            palette = mypal)




# Colores escogidos manualmente

# Especificar colores por nombre. (Se puede hacer por código hexadecimal)
pal = c("pink1", "lemonchiffon2", "skyblue")

  
tm_shape(mapamex_simple) +
    tm_borders() +
    tm_fill("categorica",  
            style = "cat",
            #Pasar argumento con paleta que queremos usar
            palette = pal)



# Escoger el color específicamente para cada categoría


pal <- c("conejo" = "lightblue", "gato" = "green", "perro"= "orange")
  
tm_shape(mapamex_simple) +
    tm_borders() +
    tm_fill("categorica", palette = pal,   style ="cat") 


# Personalizar leyenda (título, posición etc)

  
tm_shape(mapamex_simple) +
    tm_borders() +
    tm_fill(col = "categorica", #color depende de la variable categorica
            palette = pal,      #colores vienen del objeto pal
            style ="cat", 
            title = "Animal"    # Título de las leuendas
            ) +
    
    tm_legend(position = c("left", "bottom"), #Posicion de leyenda
              title.size = 2,               #Tamaño de letras de título 
                                            # de leyenda
              title.color = "blue",         #Color titulo leyenda
              text.size = 1.5,              #tamaño letra categorias
              text.color = "red",           # Color letra categorias
              title.fontfamily = "serif")


#La posicion de la paleta se puede deterinar con valores entre 0 y 1
# donde (0,0) es la parte izquiera inferior
  
tm_shape(mapamex_simple) +
    tm_borders() +
    
    tm_fill(col = "categorica", 
            palette = pal,     
            style ="cat", 
            title = "Animal"    
    ) +
    tm_legend(position = c(0.15, 0.25))
              


#Añadir y personalizar título

#especificar el lugar
  
tm_shape(mapamex_simple) +
    tm_borders() +
    tm_fill("categorica", palette = pal,   style ="cat", title = "Animal") +
    tm_layout(main.title = "Mascotas en México",
              main.title.size = 3,
              main.title.color = "slateblue",
              main.title.position = "center")


# Otros elementos gráficos

#Bubbles
# Llenar los polígonos con la variable categórica y añadir variable numérica
# proporcional al tamaño del círculo
  
tm_shape(mapamex_simple) +
    tm_borders() +
    tm_fill(col ="categorica",   
            style ="cat", 
            title = "Animal") +
    tm_bubbles(size= "numerica2", #tamaño del cíurculo proporcional a la variable
               legend.size.is.portrait = TRUE, 
               title.size = "Cantidad",
               col= "red"    # Todos los círculos rojos
               ) 
   
# Variable categórica graficada con los círculos.
# Ahora el color indica el valor de la variable


  
tm_shape(mapamex_simple) +
    tm_borders() +
    tm_fill(col ="numerica",   
            style ="equal" ) +
    tm_bubbles(col= "categorica", #color determina el valor de la variable
               legend.size.is.portrait = TRUE, 
               title.size = "Animal",
               size = 2  # se puede determinar manualmente el tamaño del circulo
               ) 

# La variable graficada  con la forma de los símbolos. 
  
tm_shape(mapamex_simple) +
    tm_borders() +
    tm_fill(col ="numerica", 
            style ="equal" ) +
    tm_symbols(shape= "categorica", 
               legend.size.is.portrait = TRUE, 
               col = "lightblue",
               size = 1.5  ) 



## Guardar mapa


#Guardarlo como imagen jpg

#primero se asigna a un objeto
mi_mapa <-
    tm_shape(mapamex_simple) +
    tm_borders() +
    tm_fill(col ="categorica",   
            style ="cat", 
            title = "Animal") +
    tm_bubbles(size= "numerica2", #tamaño del cíurculo proporcional a la variable
               legend.size.is.portrait = TRUE, 
               title.size = "Cantidad",
               col= "red"    # Todos los círculos rojos
    ) 


#salvar mapa
tmap_save(mi_mapa, "mimapa.jpg")

#salvar mapa, determinar ancho (default is pixeles)
tmap_save(mi_mapa, "mimapa2.jpg",width=4000)

# salvar mapa, con margenes

tmap_save(mi_mapa, "mimapa3.jpg",width=4000,  outer.margins = c(0.08, 0.08, 0.08, 0.08))


