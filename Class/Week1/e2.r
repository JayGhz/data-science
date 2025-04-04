# Ejemplo 2
# Una dataframe para la entidad usuario de una aplicacion

user <- data.frame(
  ID = c(1, 2, 3, 4, 5),
  Nombre = c("Juan", "Ana", "Pedro", "Maria", "Luis"),
  Edad = c(25, 30, 22, 28, 35),
  Ciudad = c("Madrid", "Barcelona", "Madrid", "Valencia", "Barcelona")
)

print(user, row.names = FALSE)