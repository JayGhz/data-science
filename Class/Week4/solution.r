################################################################
# Uso de tablas, listas y vectores con R
################################################################

library(rvest)
library(xml2)
library(XML)



# Caso 1: Accederemos a la pagina web de la UPC, específicamente
# a la de la carrera de Ciencias de la Computación

# a) Creamos la variable con el URL
upc_url <- "https://pregrado.upc.edu.pe/facultad-de-ingenieria/ciencias-de-la-computacion/"

# b) Leemos cada línea de la pagina
upc_read <- readLines(upc_url, encoding = "UTF-8", warn = FALSE)

# c) Analizamos el contenido de la pagina
parsed_upc <- htmlParse(upc_read, encoding = "UTF-8")

# d) Identificamos los ‘párrafos’ de la pagina
upc_enter_text <- parsed_upc["//p"]

# e) Averiguamos cuantos párrafos existen en la pagina
length(upc_enter_text)

# f) Visualizamos el contenido de alguno de los párrafos
upc_enter_text[[10]]

# g) Averiguamos cuantos enlaces tiene la pagina
length(getHTMLLinks(upc_read))

# h) Averiguamos cuantas tablas tiene la pagina
length((readHTMLTable(upc_read)))



# Caso # 2: Accederemos a Wikipedia, a este enlace en particular:
# https://es.wikipedia.org/wiki/Ayuda:Tablas

# a) Creamos la variable con el URL
wiki_url <- "https://es.wikipedia.org/wiki/Ayuda:Tablas"

# b) Leemos cada línea de la pagina
wiki_read <- readLines(wiki_url, encoding = "UTF-8", warn = FALSE)

# c) Analizamos el contenido de la pagina
parsed_wiki <- htmlParse(wiki_read, encoding = "UTF-8")

# d) Identificamos los ‘párrafos’ de la pagina
wiki_intro_text <- parsed_wiki["//p"]

# e) Averiguamos cuantos párrafos existen en la pagina
length(wiki_intro_text)

# f) Visualizamos el contenido de alguno de los párrafos
wiki_intro_text[[2]]

# g) Averiguamos cuantos enlaces tiene la pagina
length(getHTMLLinks(wiki_read))

# h) Averiguamos cuantas tablas tiene la pagina
length((readHTMLTable(wiki_read)))

# i) Consultamos los nombres de las tablas
names(readHTMLTable(wiki_read))

# j) Consultamos una tabla distinta del NULL
readHTMLTable(wiki_read)$"Una tabla ejemplo\n"



# Caso 3: Vamos a raspar el sitio web de IMDb para los 250 largometrajes
# más populares durante el 2022

# a) Cargamos los paquetes tidyverse y rvest
library(tidyverse)
library(rvest)

# b) Especificamos la URL que deseamos analizar, utilizando la instrucción read_html leemos el código HTML
url <- "https://web.archive.org/web/20220201012049/https://www.imdb.com/chart/top/"

# c) A la instrucción html_nodes le especificamos que selector CSS queremos recuperar
html <- read_html(url)

# d) Estos datos tienen una estructura tabular clara, por lo que se usará el comando html_table()
table <- html |>
  html_element("table") |>
  html_table()
table

head(data.frame(table))

# e) Necesitamos realizar un previo procesamiento
# Primero: cambiaremos el nombre de las columnas para que sea más fácil trabajar con ellas y
# eliminaremos los espacios en blanco superfluos en la clasificación y el título.
# Haremos esto con select() (en lugar de rename()) para cambiar el nombre y seleccionar solo
# estas dos columnas en un solo paso.

# Segundo: eliminaremos las nuevas líneas y los espacios adicionales y luego aplicaremos
# separa_wider_regex() para extraer el título, el año y la clasificación en sus propias variables.

ratings <- table |>
  select(
    rank_title_year = `Rank & Title`,
    rating = `IMDb Rating`
  ) |>
  mutate(
    rank_title_year = str_replace_all(rank_title_year, "\n +", " ")
  ) |>
  separate_wider_regex(
    rank_title_year,
    patterns = c(
      rank = "\\d+", "\\. ",
      title = ".+", " +\\(",
      year = "\\d+", "\\)"
    )
  )
ratings

head(data.frame(ratings))

# Otros ejemplos:
# https://statsandr.com/blog/web-scraping-in-r/
# https://rpubs.com/Semilla_389/989829



# Área de trabajo

# 1. Guardamos el área de trabajo
setwd("D:/UPC/Fundamentos de Data Science")
save.image(file = "resultados_web_scraping.RData")

# 2. Cargamos el área de trabajo
setwd("D:/UPC/Fundamentos de Data Science")
load(file = "resultados_web_scraping.RData")
