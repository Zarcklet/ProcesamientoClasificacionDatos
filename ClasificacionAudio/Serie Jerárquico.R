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

serie_original1 <- ts(base$C1,
                      frequency = 52, start = c(2019, 1))
serie_original2 <- ts(base$C2,
                      frequency = 52, start = c(2019, 1))
serie_original3 <- ts(base$C3,
                      frequency = 52, start = c(2019, 1))
serie_original4 <- ts(base$C4,
                      frequency = 52, start = c(2019, 1))
serie_original5 <- ts(base$C5,
                      frequency = 52, start = c(2019, 1))

serie_arima1 <- auto.arima(serie_original1, D=1)
serie_arima2 <- auto.arima(serie_original2, D=1)
serie_arima3 <- auto.arima(serie_original3, D=1)
serie_arima4 <- auto.arima(serie_original4, D=1)
serie_arima5 <- auto.arima(serie_original5, D=1)
summary(serie_arima1)
summary(serie_arima2)
summary(serie_arima3)
summary(serie_arima4)
summary(serie_arima5)

pronostico1 <- forecast(serie_arima1, h = 12, level = 95)
pronostico2 <- forecast(serie_arima2, h = 12, level = 95)
pronostico3 <- forecast(serie_arima3, h = 12, level = 95)
pronostico4 <- forecast(serie_arima4, h = 12, level = 95)
pronostico5 <- forecast(serie_arima5, h = 12, level = 95)

plot(pronostico1)
plot(pronostico2)
plot(pronostico3)
plot(pronostico4)
plot(pronostico5)


fecha <- as.Date("08/05/2022", format = "%d/%m/%Y")
fecha2 <- as.Date("02/08/2022", format = "%d/%m/%Y")
fecha_pro <- as.Date(seq(fecha, fecha2, by = "week"),
                     format = "%d/%m/%Y")
fecha_pro <- fecha_pro[-1]
fecha_pro

PTotal <- rep(1, length(fecha_pro))
Semana <-  seq(max(base$Time)+1, max(base$Time)+12)

PronParti <- data.frame(fecha_pro, Semana, PTotal,
                        PPC1 = pronostico1$mean,
                        PPC2 = pronostico2$mean,
                        PPC3 = pronostico3$mean,
                        PPC4 = pronostico4$mean,
                        PPC5 = pronostico5$mean)
PronParti
PronParti[1, 4:length(PronParti)]
sum(PronParti[1, 4:length(PronParti)])

Semana1_pron <- S%*%t(PronParti[1, 3:length(PronParti)])
Semana1_pron
sum(Semana1_pron[-1])

PronJerar <- as.data.frame(t(S%*%t(PronParti[, 3:length(PronParti)])))
names(PronJerar) <- c("PJTotal", "PJC1", "PJC2", "PJC3",
                      "PJC4", "PJC5")
PronJerar

PJT <- cbind(PronParti, PronJerar)
View(PJT)


