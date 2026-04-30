
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

# install.packages("pacman")

pacman::p_load(ipumsr, dplyr, ggplot2)

setwd("C:/User/taller/")
dir()


# Descarga manual de datos -----
ddi <- read_ipums_ddi("ipumsi_00034.xml")
data <- read_ipums_micro(ddi)

# Muy importante:
ipums_conditions()


# Diccionario de datos -----
View(ddi$var_info)
View(as.data.frame(ddi$var_info$val_labels[[12]]))
names(data)
unique(data[, c("COUNTRY","YEAR")])


# Identificadores -----
data$id_hog<-paste(as.character(data$SAMPLE), as.character(data$SERIAL), sep="_")
data$id_per<-paste(as.character(data$SAMPLE), as.character(data$SERIAL), 
                   as.character(data$PERNUM), sep="_")


# Guardar datos -----
save(ddi, data, file="datos_uruguay.RData")


# Probabilidad de nuliparidad en la cohorte -----

prob_no_hijos <- data %>%
  group_by(YEAR, COUNTRY) %>%
  summarise(
    total_mujeres=sum(PERWT, na.rm=T),
    sin_hijos=sum(PERWT * (CHBORN==0), na.rm = T),
    prob_sin_hijos=100 * sin_hijos / total_mujeres)
