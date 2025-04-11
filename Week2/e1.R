################################################################
#Adquisición, preparación y visualización de datos con R
################################################################

#1. Carga de datos
data <- read.csv("Class/Week2/titanic_data.csv",header=T,sep = ",")

#2. Inspeccionar datos
View(data)

str(data)

names(data)

head(data)
head(data,10)

tail(data)
tail(data,10)

summary(data)
summary(data$Age)

str(data)
data$Survived <- as.factor(data$Survived)
data$Pclass <- as.factor(data$Pclass)
data$Sex <- as.factor(data$Sex)
data$Embarked <- as.factor(data$Embarked)
str(data)

#3. Limpieza de datos

#Función sin_valor(dataframe) que desliega cuantos valores NA posee cada variable
sin_valor <- function(x){
  sum = 0
  for(i in 1:ncol(x))
  {
    cat("En la columna",colnames(x[i]),"total de valores NA:",colSums(is.na(x[i])),"\n")
  }
}
sin_valor(data)

#Función en_blanco(dataframe) que desliega cuantos valores en blanco posee cada variable
en_blanco <- function(x){
  sum = 0
  for(i in 1:ncol(x))
  {
    cat("En la columna",colnames(x[i]),"total de valores en blanco:",colSums(x[i]==""),"\n")
  }
}
en_blanco(data)

#a. Investiguemos que pasajeros tienen en blanco el atributo Embarked
data$PassengerId[data$Embarked == ""]

#b. Verifiquemos ahora en que clase viajaban dichos pasajeros y cuanto les costó el boleto
data$Pclass[data$PassengerId == 62]
data$Fare[data$PassengerId == 62]

data$Pclass[data$PassengerId == 830]
data$Fare[data$PassengerId == 830]

#c. Creamos un nuevo dataset que no contenga a esos dos pasajeros
library(dplyr)
data_new1 <- data %>% filter(PassengerId != 62 & PassengerId != 830)

#d. Usamos la librería ggplot2 y scales para graficar el precio (Fare) 
#Promedio que costó un boleto por clase (Pclass) y puerto de embarque (embarked).

library(ggplot2)
library(scales)
ggplot(data = data_new1,aes(x = Embarked, y = Fare, fill = factor(Pclass))) + 
    geom_boxplot() + 
    geom_hline(aes(yintercept = 80), colour = "red", linetype = "dashed", lwd = 2) + 
    scale_y_continuous(labels = dollar_format()) + 
    theme_bw()

data$Embarked[c(62, 830)] <- "C" # Inputacion de datos

#4.Visualización de datos

#a. Sobrevivencia de Pasajeros del Titanic
#¿Cuál fue la tasa de supervivencia?
table(data$Survived)
prop.table(table(data$Survived))

barplot(table(data$Survived), 
        main="Pasajeros en Titanic",
        names= c("Murieron", "Sobrevivieron"))

ggplot(data)+
  geom_bar(aes(x=Survived, fill=Survived))

#b. Pasajeros del Titanic por Clase
table(data$Pclass)
prop.table(table(data$Pclass))

barplot(table(data$Pclass), 
        main="Pasajeros de Titanic por Clase", 
        names= c("Primera", "Segunda", "Tercera"))

ggplot(data)+
  geom_bar(aes(x=Pclass, fill=Pclass))

#c. Pasajeros del Titanic por Genero
table(data$Sex)
prop.table(table(data$Sex))

barplot(table(data$Sex), 
        main="Pasajeros del Titanic por Genero", 
        names= c("Mujer", "Hombre"))

ggplot(data)+
  geom_bar(aes(x=Sex, fill=Sex))

#d. Sobrevivencia de Pasajeros por Genero
table(data$Survived, data$Sex)
counts <- table(data$Survived, data$Sex)

barplot(counts, col=c("green","yellow"), 
        legend = c("Murieron", "Sobrevivieron"), 
        main = "Sobreviviencia de Pasajeros por Genero")

ggplot(data) +
  geom_bar(aes(Sex, fill = Survived))

library(ggmosaic)
ggplot(data) + 
  geom_mosaic(aes(x = product(Sex), fill = Survived))

#e. Sobrevivencia de Pasajeros por Clase
table(data$Survived, data$Pclass)
counts1 <- table(data$Survived, data$Pclass) 

barplot(counts1, col=c("green","yellow"), 
        legend = c("Murieron","Sobrevivieron"), 
        main = "Sobreviviencia de Pasajeros por Clase", 
        names= c("Primera", "Segunda", "Tercera"))

ggplot(data) +
  geom_bar(aes(Pclass, fill = Survived))

ggplot(data) + 
  geom_mosaic(aes(x = product(Pclass), fill = Survived))

#5. Otros análisis
#a. Análisis de correlación mediante el uso de gráficos de dispersión
ggplot(data)+
  geom_point(aes(x=Age,y=Fare), na.rm=TRUE)

ggplot(data)+
  geom_point(aes(x=Age,y=Fare), na.rm=TRUE)+
  geom_smooth(aes(x=Age,y=Fare), method="lm", na.rm=TRUE)

coefficients(lm(Fare ~ Age, data = data))

ggplot(data)+
  geom_point(aes(x=Age,y=Fare, color=Pclass), na.rm=TRUE)+
  geom_smooth(aes(x=Age,y=Fare, color=Pclass), method="lm", na.rm=TRUE)

#b. Análisis de la tarifa del pasajero según la clase
summary(data$Fare)

aggregate(Fare ~ Pclass, data = data, summary)

ggplot(data) +
  geom_boxplot(aes(x=Pclass, y=Fare, fill=Pclass), na.rm=TRUE)

#c. Análisis de la edad del pasajero según la clase
summary(data$Age)

aggregate(Age ~ Pclass, data = data, summary)

ggplot(data) +
  geom_boxplot(aes(x=Pclass, y=Age, fill=Pclass), na.rm=TRUE)

# #6. Save workspace
setwd("Class/Week2")
write.csv(data, "titanic_results.csv")