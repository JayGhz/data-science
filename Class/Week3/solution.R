################################################################
#Uso de tablas, listas y vectores con R
################################################################

#1. Carga de datos
print(iris)

#2. Inspeccionar datos

#2.1Instrucciones básicas con data sets

#Visualizar primeras seis filas del dataset
head(iris)

#Visualizar primeras seis últimas filas del dataset
tail(iris)

#Resumen estadístico de las columnas
summary(iris)

#Estructura textual del objeto
str(iris)

#Filas x columnas
dim(iris)

#Número de filas
nrow(iris)

#Número de filas
ncol(iris)

#Se obtiene el nombre de las columnas
colnames(iris)

#2.2 Selección de filas y columnas de un conjunto de datos

#Visualizar 7 primeras filas del dataset
iris[1:7,]

#Visualizar columnas 3 y 4 del dataset
iris[, 3:4]

#Visualizar 10 primeras filas de las columnas 3 y 4 del dataset
iris[1:10, 3:4]

#Visualiza todos los valores de la columna llamada Species del dataset
iris[, "Species"]

#Visualiza todos los valores de la columna llamada Species del dataset, equivale a iris[, "Species"]
iris$Species

#Visualiza todas las filas que cumplan la condición que la especie sea “setosa” dentro del dataset
iris[iris$Species == "setosa",]

#Visualiza todas las filas que cumplan la condición que la especie sea “setosa” y que la longitud del petalo sea mayor o igual a 1.5
iris[iris$Species == "setosa" & iris$Petal.Length >= 1.5,]

#2.3 Copia o eliminación de un conjunto de datos

#my.iris es una copia de iris
my.iris <- iris
head(my.iris)

#Lista de objetos que se mantienen en la memoria (solo los creados por nosotros)
ls()

#Borra el objeto my.iris
rm(my.iris)
ls()

#2.4 Creación / eliminación de columnas en un conjunto de datos

#Crear columna
my.iris <- iris
my.iris$Petal.Area <- my.iris$Petal.Length * my.iris$Petal.Width

#Eliminar columna:
my.iris$Petal.Area <- NULL

#2.5 Ordenamiento de filas dentro del conjunto de datos

#Podemos crear un dataset llamado my.iris donde las filas estén ordenadas según la longitud de los pétalos
my.iris <- iris[order(iris$Petal.Length),]

#2.6 Creación de Vectores

#El vector numérico x, contempla número del 1 al 10
x <- 1:10

#El vector numérico y, está compuesto por las categorías (o niveles) de especies del dataset iris
y <- iris$Species

#Observamos los vectores creados con la instrucción
ls()

#Se puede crear también secuencias de números
1:5

5:1

c (1:5, 5:1)

c(1, 5, -1, 4)

c("uno", "dos", "tres")

#Se utiliza la función seq() para reemplazar al operador “:”
seq(1, 5)

#Repite la secuencia n veces
rep(1:5, 5)

#Repite cada element n veces
rep(1:5, each = 5)

#2.6.1 Exploración de vectores

plot(x)

length(x)

table(y)

summary(y)

head(x)

tail(x)

#El vector “y” equivale a table(iris$Species)
table(iris$Species)

#2.6.2. Selección de elementos de un vector

x <- x^2

x[1:3]

#Selecciona los índices indicados
x[c(1,3)]

x[x > 25]

#Seleccion de elementos de forma inversa
x[3:1]

#Remueve los dos primeros elementos
x[-(1:2)]

#Remueve el elemento equivalente a la posición señalada
x[-length(x)]

#Saber a qué etiqueta corresponde cada conteo
w <- table(iris$Species)

w["setosa"]

w[c("setosa", "virginica")]

#cambiar el nombre de una columna
my.iris <- iris
colnames(my.iris)[5] <- "Especie"
colnames(my.iris)

#Igual sucede con los nombres de un vector, pero en este caso, la función correspondiente a utilizar es names
z <- table(iris$Species)

names(z)

names(z)[1] <- "Tipo 1"

names(z)

#Con el corchete, además de seleccionar, podemos cambiar el contenido de los elementos seleccionados de un vector
z <- 1:10
z

z[z < 5] <- 100
z

#Cuando se quiere obtener una serie de elementos al azar dentro de un vector, utilizamos la función sample
x <- 1:10
x

sample(x,4)

sample(x,50)

sample(x, 50, replace = TRUE)

#2.6.3. Creación de funciones

x <- 1:10

mean(x)

max(x)

median(x)

sum(x)

prod(x)

#Función suma de cuadrados
x <- 1:10

suma_cuadrados <- function(x) sum(x*x)

suma_cuadrados(x)

#Función media

media <- function(x)
  { 
  longitud <- length(x) 
  suma <- sum(x) 
  suma / longitud
  }

#2.6.4. La función tapply
tapply(iris$Petal.Length, iris$Species, mean)

#2.7 Creación de Listas

#Las listas son objetos de R
is.list(iris)

#Creación de listas
x <- list("a" = 2.5, "b" = TRUE, "c" = 1:3)
x

typeof(x)

length(x)

str(x)

#crear la misma lista sin las etiquetas
x <- list(2.5,TRUE,1:3)
x

#Accediendo a los componentes de una lista
x <- list(name = "John", age = 19, speaks = c("English", "French"))
x

#a. Índice usando un vector entero
x[c(1:2)]

#b. Usando un entero negativo para excluir el segundo componente
x[-2]

#c. Índice usando vector lógico
x[c(T,F,F)]

#d. Índice usando vector de caracteres
x[c("age","speaks")]

#Modificando los componentes de una lista
x[["name"]] <- "Patricia"; x

#Adicionando componentes a una lista
x[["married"]] <- TRUE 
x

#Eliminando componentes a una lista
x[["age"]] <- NULL
str(x)

x$married <- NULL

str(x)

#3.Visualización de datos

#3.1 Gráfica de variables continuas
hist(iris$Sepal.Width)

hist(iris$Sepal.Width, 
     main = "Iris: Histograma de la anchura de los sépalos", 
     xlab = "anchura del sépalo", 
     ylab = "frecuencia", 
     col = "steelblue")

#3.2 Gráfica de variables categóricas
barplot(table(iris$Species))

#3.3 Gráfica de la relación entre dos variables continuas
plot(iris$Petal.Length, iris$Petal.Width, 
     main="Edgar Anderson's Iris Data")

#3.4 Gráfica de la relación entre una variable continua y otra categórica
boxplot(iris$Sepal.Width ~ iris$Species, 
        col = "gray", 
        main = "Especies de iris\nsegún la anchura del sépalo")

#4. Guardamos el área de trabajo
setwd("D:/UPC/Fundamentos de Data Science")
save.image(file = "resultados_iris.RData")

#5. Cargamos el área de trabajo
setwd("D:/UPC/Fundamentos de Data Science")
load(file = "resultados_iris.RData")