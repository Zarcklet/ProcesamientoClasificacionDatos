rm(list = ls())

library(tseries)
library(fUnitRoots)
library(forecast)
library(lmtest)

getwd()
setwd("D:\\Documentos\\Maestria en Ciencia de Datos\\Materia MN")
getwd()

# DATOS:
# https://gml.noaa.gov/ccgg/trends/data.html

base_CO2 <- read.csv("CO2.csv")

CO2 <- ts(base_CO2$Promedio_CO2, start = c(1958, 3),
          frequency = 12)
CO2

# En el gráfico:
# La media no es constante.
# La varianza y la covarianza son constantes.
plot.ts(CO2, main = "Emisión de CO2 Mensual",
        col = "dodgerblue4",
        xlab = "Fecha",
        ylab = "CO2")





# PASO 1.
# Identificar si la serie de tiempo es estacionaria.
# Para identificar si una serie es estacionaria se puede
# utilizar gráficas o la prueba de Dickey - Fuller.
acf(CO2,
    main = "Función de Autocorrelación Simple")
pacf(CO2,
     main = "Función de Autocorrelación Parcial")

# Test Dickey - Fuller
# Hipótesis:
# H0: La serie es no estacionaria: Tiene raíz unitaria.
# H1: La serie es estacionaria: No tiene raíz unitaria.
# ¿Qué es raíz unitaria?
adf.test(CO2)
adfTest(CO2)
# No se rechaza H0. La serie no es estacionaria.

# Como nuestra serie no es estacionaria, se tiene que
# realizar una diferencia de un periodo.

# En el gráfico:
# La media es constante.
# La varianza y la covarianza son constantes.
plot.ts(diff(CO2),
        main = "Serie en primera diferencia",
        xlab = "Fecha",
        ylab = "CO2 en primera diferencia")
# Arumentos del comando diff() -> lag = 1, differences = 1

acf(diff(CO2),
    main = "AFC en Primera Diferencia")
pacf(diff(CO2),
     main = "PAFC en Primera Diferencia")

# Test Dickey - Fuller
# Hipótesis:
# H0: La serie es no estacionaria: Tiene raíz unitaria.
# H1: La serie es estacionaria: No tiene raíz unitaria.
adf.test(diff(CO2))
adfTest(diff(CO2))
# Se rechaza H0. La serie es estacionaria

# Test Estacionariedad-Tendencia
# H0: La serie temporal es estacionaria en tendencia.
# H1: La serie de tiempo no es estacionaria en tendencia.
kpss.test(CO2, null = "Trend")
# Este test responde a la pregunta de si
# la serie es estacionaria en torno a una tendencia.
# Se rechaza H0. La serie de tiempo no es estacionaria
# en tendencia.





# PASO 2.
# Identificación del modelo.
# El ACF nos da a conocer el orden del proceso
# de medias móviles MA(q).
# PACF nos da a conocer el orden del proceso
# autoregresivo AR(p).
modelo1 <- auto.arima(CO2)
modelo1

pdq <- c(1, 1, 1)
PDQ <- c(2, 1, 2)
modelo1_1 <- arima(CO2, pdq,
                   seasonal = list(order = PDQ,
                                   period = 12))
modelo1_1





# PASO 3.
# Validación del modelo.
# Test Ljung-Box
# Es un tipo de prueba estadística de si un grupo
# cualquiera de autocorrelaciones de una serie de tiempo
# son diferentes de cero.

# H0: Los datos se distribuyen de forma independiente
# (es decir, las correlaciones en la población de la
# que se toma la muestra son 0, de modo que cualquier
# correlación observada en los datos es el resultado de
# la aleatoriedad del proceso de muestreo).
# H1: Los datos no se distribuyen de forma independiente.
checkresiduals(modelo1_1)
# No se rechaza H0. Los datos se distribuyen de forma
# independiente.

# Estimaciones del modelo
estimaciones <- fitted.values(modelo1_1)

# Residuales del modelo
residuales <- modelo1_1$residuals

# Varianza constante
plot(estimaciones, residuales,
     main = "Residuos vs Estimaciones", font.lab  = 2,
     xlab = "Estimaciones", ylab = "Residuales", pch = 16)
abline(h=0, lty = 5, col = "red", lwd = 3)

# Normalidad con media cero
# H0: Datos provienen de una dist normal.
# H1: Datos provienen de otra dist.
ks.test(residuales, pnorm, mean = 0, sd = sd(residuales))
# No se rechaza H0. Datos provienen de una dist normal.

# Gráfico de normalidad
qqnorm(residuales, xlab = "Residuo", ylab = "Porcentaje",
       main = "Normalidad de Residuos")
qqline(residuales, lty = 5, col = "red", lwd = 3)

# Independencia
acf(residuales, main = "Serie Residuales")

# Test Box
# H0: Los residuales son independientes.
# H1: Los residuales no son independientes.
Box.test(residuales)





# PASO 4.
# Pronóstico.
autoPred = forecast(modelo1, h = 12, level = 95)
plot(autoPred)

manualPred <- predict(modelo1_1, n.ahead = 12)
ts.plot(CO2, manualPred$pred, lty = c(1, 3))



