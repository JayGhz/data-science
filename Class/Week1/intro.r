#############################################
#Uso básico de R
#############################################


# Ruta de trabajo
# getwd()
# setwd("E:/Documents/FundamentosDS")
# getwd()
options(scipen = 999)

#Creación de vectores
y <- c(4, 3, 5)
letras <- c("hombre", "mujer")


# Datos de edad
edad <- c(15, 12, 27, 55, 63, 63, 24, 21, 70)
str(edad)

# Mostrar tabla de frecuencias de edad
table(edad)

# Creación de una base de datos
genero <- c(1,1,2,1,2,2,2,1,2)
ingreso <- c(100000,300000,500000,340000,
             300000,500000,650000,410000,
             750000)
acuerdo <- c(1,1,3,2,4,1,5,3,2)

# Crear el dataframe
aborto <- data.frame(genero, ingreso, acuerdo)

# Guardar el dataframe en un archivo CSV
write.csv(aborto, file = "aborto.csv", row.names = FALSE, col.names = FALSE)
