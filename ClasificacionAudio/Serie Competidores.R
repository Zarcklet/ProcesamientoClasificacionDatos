rm(list = ls())

library(tseries)
library(fUnitRoots)
library(forecast)
library(lmtest)
library(readr)
library(ggplot2)
library(reshape2)
library(dplyr)

getwd()
setwd("D:\\Documentos\\Maestria en Ciencia de Datos\\Materia MN")
getwd()

base <- read.csv("Competidor10.csv", header = TRUE, sep = ",")
View(base)

serie_original <- ts(base$Product1,
                     frequency = 52, start = c(2019, 1))

serie_arima <- auto.arima(serie_original)
summary(serie_arima)

plot(serie_arima$x, col = "#008B8B", lwd = 2,
     xlab = "Tiempo",
     ylab = "Ventas",
     main = "Ventas Reales vs Estimadas")

par(new = TRUE)

plot(serie_arima$fitted, col = "#F0945D",
     xlab = "",
     ylab = "",
     main = "",
     lwd = 2,
     axes = FALSE)

legend(x = "bottomleft",
       legend = c("Real", "Estimación"),
       lty = c(1, 1),
       col = c("#008B8B", "#F0945D"),
       lwd = 2,
       #horiz = TRUE,
       bty = "n")

pronostico <- forecast(serie_arima, h = 25, level = 95)

plot(pronostico, main = "Pronóstico de Ventas",
     xlab = "Tiempo",
     ylab = "Ventas",
     lwd = 2)

fecha <- as.Date("08/05/2022", format = "%d/%m/%Y")
fecha2 <- as.Date("05/11/2022", format = "%d/%m/%Y")
fecha_pro <- as.Date(seq(fecha, fecha2, by = "week"),
                     format = "%d/%m/%Y")
fecha_pro <- fecha_pro[-1]
fecha_pro


#########################################################

base <- read.csv("Competidor10.csv", header = TRUE, sep = ",")
clase <- "Competidor 10"

if (ncol(base) == 4) {
  serie1 <- ts(base$Product1,
               frequency = 52, start = c(2019, 1))
  arima1 <- auto.arima(serie1, D = 1)
  pronostico1 <- forecast(arima1, h = 25, level = 95)
  serie2 <- ts(base$Product2,
               frequency = 52, start = c(2019, 1))
  arima2<- auto.arima(serie2)
  pronostico2 <- forecast(arima2, h = 25, level = 95)
  estimaciones <- c(arima1$fitted, arima2$fitted)
  base_p1 <- data.frame(fecha_pro = fecha_pro,
                        pronostico = as.numeric(pronostico1$mean))
  base_p2 <- data.frame(fecha_pro = fecha_pro,
                        pronostico = as.numeric(pronostico2$mean))
  base_p1 <- base_p1 %>% mutate(variable = "Product1")
  base_p2 <- base_p2 %>% mutate(variable = "Product2")
  base_com <- rbind(base_p1, base_p2)
  
} else {
  serie1 <- ts(base$Product1,
               frequency = 52, start = c(2019, 1))
  arima1 <- auto.arima(serie1)
  pronostico1 <- forecast(arima1, h = 25, level = 95)
  estimaciones <- c(arima1$fitted)
  base_p1 <- data.frame(fecha_pro = fecha_pro,
                        pronostico = as.numeric(pronostico1$mean))
  base_p1 <- base_p1 %>% mutate(variable = "Product1")
  base_com <- base_p1
  
}

aux2 <- base_com %>% mutate(Competidor = clase)
#aux <- melt(base, id.vars = c("YMD", "Time"))
#aux <- aux %>% mutate(Competidor = clase)
#aux$Estimaciones <- estimaciones

#Ventas_completo <- data.frame()
#Ventas_completo <- rbind(Ventas_completo, aux)
#Pronostico_completo <- data.frame()
Pronostico_completo <- rbind(Pronostico_completo, aux2)


#########################################################

#write_delim(Ventas_completo, "Ventas Completo.csv",
#            col_names = TRUE, delim = ",")

write_delim(Pronostico_completo, "Pronostico Completo.csv",
            col_names = TRUE, delim = ",")




