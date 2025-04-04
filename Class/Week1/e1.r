library(ggplot2)
library(dplyr)
library(gridExtra)  

# Ejemplo 1
# Crear un dataframe simple de grafico de barras y grafico circular
data <- data.frame(
  Categoria = c("A", "B", "C", "D", "E"),
  Valor = c(25, 30, 15, 20, 10)
)

# grafico barras
bar_plot <- ggplot(data, aes(x = Categoria, y = Valor, fill = Categoria)) +
  geom_bar(stat = "identity", show.legend = FALSE) +
  theme_minimal() +
  scale_fill_brewer(palette = "Set3") + 
  labs(title = "Gráfico de Barras", x = "Categoría", y = "Valor") +
  theme(
    plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
    axis.text = element_text(size = 12),
    axis.title = element_text(size = 14, face = "bold")
  ) +
  theme(panel.grid = element_blank())

# grafico circular
pie_plot <- ggplot(data, aes(x = "", y = Valor, fill = Categoria)) +
  geom_bar(stat = "identity", width = 1, show.legend = FALSE) +
  coord_polar(theta = "y") +
  scale_fill_brewer(palette = "Set3") +
  labs(title = "Gráfico Circular") +
  theme_void() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
    axis.text = element_blank(),
    axis.title = element_blank()
  )
grid.arrange(bar_plot, pie_plot, ncol = 2)