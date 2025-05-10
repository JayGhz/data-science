################################################################
# Preprocesamiento - Limpieza de datos
################################################################

setwd("C:/Users/jayka/Documents/Courses/data-science
      /Class/Week5/missing_data.csv")
data <- read.csv("missing-data.csv", na.strings = "")

# 1. Eliminar datos sin valor

# Ahora debemos limpiar este dataframe con la instrucción na.omit()
data_limpia <- na.omit(data)

# Consultemos si es NA el valor de la cuarta fila y segunda columna (atributo)
is.na(data[4, 2])

# ¿Es NA el valor de la cuarta fila y primera columna?
is.na(data[4, 1])

# Veamos, de toda una columna, por ejemplo, del atributo
# Income del dataframe data que valores contienen un NA.
is.na(data$Income)

# 2. Limpieza selectiva de datos sin valor

# Caso 1
# Si, solo queremos eliminar los NA de la variable Income haremos lo siguiente
data_income_limpio <- data[!is.na(data$Income)]

# Caso 2
# Limpiar datos NA de todo el dataframe
complete.cases(data)
data_limpia2 <- data[complete.cases(data), ]

# Caso 3
# Limpiar los valores ‘cero’ de una variable de un dataframe

# Convertir los ceros de Income en NA
data$Income[data$Income == 0]

# Si mantenemos los ceros en la variable Income y
# aplicáramos el promedio a esa variable, nos bajaría
# bastante el promedio, por tanto, es preferible tener
# ese valor como NA en lugar de cero.
data$Income[data$Income == 0] <- NA

# Luego de asignarle NA a los valores cero de la variable
# Income verificamos sus valores:
data$Income[data$Income == 0]

# Caso 4: Limpiar los valores NA con valores/métricas estadísticas
# y/o matemáticas

# Media
mean(data$Income)
mean(data$Income, na.rm = TRUE)

# Desviación estándar
sd(data$Income)
sd(data$Income, na.rm = TRUE)

# Suma
sum(data$Income)
sum(data$Income, na.rm = TRUE)

# 3. Reemplazo de datos NA con la media o la extracción aleatoria de valores
data <- read.csv("missing-data.csv", na.strings = "")

# Caso 1: Reemplazo de datos NA con la media de la población
data$Income[data$Income == 0] <- NA
data$Income.mean <- ifelse(is.na(data$Income),
  mean(data$Income, na.rm = TRUE),
  data$Income
)

# Caso#2: Reemplazo de datos NA con un valor aleatorio simple
rand_valor <- function(x) {
  faltantes <- is.na(x)
  tot_faltantes <- sum(faltantes)
  x_obs <- x[!faltantes]
  valorado <- x
  valorado[faltantes] <- sample(x_obs, tot_faltantes, replace = TRUE)
  return(valorado)
}

# Creamos una nueva función que llamaremos random_df, que recibirá
# como parámetros un dataframe y los nombres de sus columnas que queremos
# pre-procesar.
random_df <- function(df, cols) {
  nombres <- names(df)
  for (col in cols)
  {
    nombre <- paste(nombres[col], "valorado", sep = ".")
    df[nombre] <- rand_valor(df[, col])
  }
  df
}

data_limpio <- random_df(data, c(1, 2))
View(data_limpio)

# 4. Evitar duplicación de observaciones

familia_salario <- c(40000, 60000, 50000, 80000, 60000, 70000, 60000)
familia_integrantes <- c(4, 3, 2, 2, 3, 4, 3)
familia_auto <- c("Lujo", "Compacto", "SUV", "Lujo",
                  "Compacto", "Compacto", "Compacto")

familia <- data.frame(familia_salario, familia_integrantes, familia_auto)

View(familia)

duplicated(familia)

familia[duplicated(familia), ]

unique(familia)

familias_unicas <- unique(familia)
View(familias.unicas)