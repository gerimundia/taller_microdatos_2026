
# ============================================================================

# Taller de uso de muestras de microdatos censales IPUMS-I
# COLMEX
# Abril, 2026
# Adriana Robles
# arrobles@colmex.mx
# Se omiten tildes de manera deliberada. 

# ============================================================================


# Definicion de ambiente y descarga de paquetes ----

rm(list=ls())
gc()

pacman::p_load(ipumsr, dplyr)

setwd("C:/User/taller/")


# Autenticacion con API ----
apikey <- "COLOCAR AQUI SU API KEY"


# Definicion del extracto ----
extracto1 <- define_extract_micro(
  collection = "ipumsi",
  description = "Datos de Uruguay de 2011 mujeres 4549",
  samples = c("uy2011a"),
  variables = list("EDATTAIND", "MARSTD",
                   var_spec("SEX", case_selections = "2"),
  var_spec("AGE", case_selections = as.character(45:49)),
  var_spec("CHBORN", attached_characteristics = "mother")))

extracto1


# Enviar peticion ----
extract_1_peticion <- submit_extract(extracto1, api_key = apikey)
extract_1_peticion$number
extract_1_peticion$status


# Revisar peticion ----
is_extract_ready("ipumsi:35", api_key = apikey)


# Descargar datos ----
filepath <- download_extract("ipumsi:35", api_key = apikey)
ddi <- read_ipums_ddi(filepath)
data <- read_ipums_micro(ddi)


# Guardar datos ----
save(ddi, data, file="data/datos_uruguay.RData")

