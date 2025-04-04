#Ejemplo 4
x <- seq(1, 100, by = 1) 
y <- x + rnorm(100, mean = 0, sd = 10)  


df <- data.frame(x, y)

# Crear un gráfico de dispersion
plot(df$x, df$y, main = "Grafico de Dispersion", xlab = "Eje X", ylab = "Eje Y", pch = 19, col = "blue")