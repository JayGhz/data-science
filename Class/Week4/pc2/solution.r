rm(list = ls(all = TRUE))
graphics.off()
cat("\014")
# Pregunta 1
myiris <- iris
list(iris[iris$Petal.Length >= 3 & iris$Petal.Length <= 5, ])
# Al ver la lista se puede ver que la gran mayoria de flores son
# versicolor y algunas virginica

# Pregunta 2
list(iris[iris$Petal.Width > 1.5, ])
# Al ver la lista se ve que la especie de flor que predomina es virginica
# aunque hay cinco especies versicolor que tienen un ancho mayor a 1.5

# Pregunta 3
flores <- list(iris[iris$Petal.Length > 2 * iris$Sepal.Width, ])
nrow(flores[[1]])
# El numero de flores es 10 en las cuales se ve que el unico tiplo de flor
# que cumple la condicion es virginica

# Pregunta 4
especies <- split(iris$Petal.Length, iris$Species)
varianza <- sapply(especies, var)
especie_max_varianza <- names(varianza)[which.max(varianza)]
especie_max_varianza
# Como resultado tenemos que virginica es la especie con mayor varianza

# Pregunta 5
list(iris[iris$Sepal.Length > 6 & iris$Sepal.Width < 3, ])
# Como resultado tenemos que las especies que cumplen estas condiciones
# son versicolor y virginica
