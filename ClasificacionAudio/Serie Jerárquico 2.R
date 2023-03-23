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

a <- matrix(rep(1, 5), ncol = 5, nrow = 1)
b <- diag(1, nrow = 5, ncol = 5)
s <- rbind(a, b)

S <- s%*%solve(t(s)%*%s)%*%t(s)
S

base <- read.csv("Participacion Competidores.csv",
                 header = TRUE, sep = ",")
View(base)
base2 <- melt(base, id.vars = c("Time", "YMD"))


# C1
serie_original1 <- ts(base$C1,
                      frequency = 52, start = c(2019, 1))
serie_arima1 <- auto.arima(serie_original1, D=1)
EC1 <- c(serie_arima1$fitted)
pronostico1 <- forecast(serie_arima1, h = 12, level = 95)

# C2
serie_original2 <- ts(base$C2,
                      frequency = 52, start = c(2019, 1))
serie_arima2 <- auto.arima(serie_original2, D=1)
EC2 <- c(serie_arima2$fitted)
pronostico2 <- forecast(serie_arima2, h = 12, level = 95)

# C3
serie_original3 <- ts(base$C3,
                      frequency = 52, start = c(2019, 1))
serie_arima3 <- auto.arima(serie_original3, D=1)
EC3 <- c(serie_arima3$fitted)
pronostico3 <- forecast(serie_arima3, h = 12, level = 95)

# C4
serie_original4 <- ts(base$C4,
                      frequency = 52, start = c(2019, 1))
serie_arima4 <- auto.arima(serie_original4, D=1)
EC4 <- c(serie_arima4$fitted)
pronostico4 <- forecast(serie_arima4, h = 12, level = 95)

# C5
serie_original5 <- ts(base$C5,
                      frequency = 52, start = c(2019, 1))
serie_arima5 <- auto.arima(serie_original5, D=1)
EC5 <- c(serie_arima5$fitted)
pronostico5 <- forecast(serie_arima5, h = 12, level = 95)


PTotal <- rep(1, dim(base)[1])
estimaciones <- data.frame(PTotal, EC1, EC2, EC3, EC4, EC5)
estimaciones_S <- as.data.frame(t(S%*%t(estimaciones)))
names(estimaciones_S) <- c("EJT", "EJC1", "EJC2", "EJC3", "EJC4", "EJC5")
estimaciones <- estimaciones[, -1]
estimaciones_S <- estimaciones_S[, -1]
estimaciones_S2 <- data.frame(Fecha = base$YMD,
                              Semana = base$Time,
                              estimaciones_S) 
estimaciones_S2 <- melt(estimaciones_S2,
                        id.vars = c("Fecha", "Semana"))


Semana <-  seq(max(base$Time)+1, max(base$Time)+12)
fecha <- as.Date("08/05/2022", format = "%d/%m/%Y")
fecha2 <- as.Date("02/08/2022", format = "%d/%m/%Y")
fecha_pro <- as.Date(seq(fecha, fecha2, by = "week"),
                     format = "%d/%m/%Y")
fecha_pro <- fecha_pro[-1]
fecha_pro

PTotal2 <- rep(1, length(fecha_pro))
pronosticos <- data.frame(PTotal2,
                          PC1 = pronostico1$mean,
                          PC2 = pronostico2$mean,
                          PC3 = pronostico3$mean,
                          PC4 = pronostico4$mean,
                          PC5 = pronostico5$mean)
PronJerar <- as.data.frame(t(S%*%t(pronosticos)))
names(PronJerar) <- c("PJT", "PJC1", "PJC2", "PJC3", "PJC4", "PJC5")
PronJerar <- PronJerar[, -1]
PronJerar2 <- data.frame(Fecha = fecha_pro,
                         Semana = Semana,
                         PronJerar)
PronJerar2 <- melt(PronJerar2, id.vars = c("Fecha", "Semana"))

write_delim(base2, "RealJ.csv",
            col_names = TRUE, delim = ",")

write_delim(estimaciones_S2, "EstimacionesJ.csv",
            col_names = TRUE, delim = ",")

write_delim(PronJerar2, "PronosticoJ.csv",
            col_names = TRUE, delim = ",")

