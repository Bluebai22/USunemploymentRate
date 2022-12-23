library(fpp2)
library(forecast)
library(readr)
library(ggplot2)
library(car)
library(tidyverse)
library(vars)           
library(urca)            #  Augmented Dickey-Fuller unit root test
rm(list = ls())
dta <- read.csv("/Users/blue/Desktop/Forecasting/finalproject_forecasting/ds3.csv")
sp500.ts <- ts(dta$sp500, frequency = 12, start = c(2000,1))
ur.ts <- ts(dta$ur, frequency = 12, start = c(2000,1))
gdp.ts <- ts(dta$gdp,frequency = 12, start = c(2000,1))
benefits.ts <- ts(dta$benefits,,frequency = 12, start = c(2000,1))
plot(sp500.ts, xlim = c(2000, 2022), xlab = "Year", ylab = "Close_Price ", main = "Close Price of S&P 500")
plot(benefits.ts, xlim = c(2000, 2022), xlab = "Year", ylab = "benefits ", main = "Benefits")
plot(gdp.ts, xlim = c(2000, 2022), xlab = "Year", ylab = "GDP", main = "GDP")

#  - Fit model with sp500 and gdp
reg1 <- auto.arima(ur.ts, xreg = cbind(sp500.ts,gdp.ts))
summary(reg1)
fore <- forecast(reg1, xreg = cbind(sp500.ts,gdp.ts))
plot(fore, xlim = c(2001, 2023),ylim = c(0,20), xlab = "Year", ylab = "Unemployment rate", main = "Unemployment rate Forecasting")
lines(reg1$fitted, col="blue")
grid()

#  - Fit model without external data
reg2 <- auto.arima(ur.ts)
summary(reg2)
fore2 <- forecast(reg2)
plot(fore2, xlim = c(2000, 2023), ylim = c(0,20),xlab = "Year", ylab = "Unemployment rate", main = "Unemployment rate Forecasting")
lines(reg2$fitted, col="blue")
grid()

# with benefits
reg3 <- auto.arima(ur.ts,xreg = benefits.ts)
summary(reg3)
fore3 <- forecast(reg3, xreg = benefits.ts)
plot(fore3, xlim = c(2000, 2023),ylim = c(0,20), xlab = "Year", ylab = "Unemployment rate", main = "Unemployment rate Forecasting")
lines(reg3$fitted, col="blue")
grid()
# with sp500
reg1 <- auto.arima(ur.ts, xreg = cbind(sp500.ts))
summary(reg1)
fore <- forecast(reg1, xreg = cbind(sp500.ts))
plot(fore, xlim = c(2000, 2023),ylim = c(0,20), xlab = "Year", ylab = "Unemployment rate", main = "Unemployment rate Forecasting")
lines(reg1$fitted, col="blue")
grid()
# with gdp
reg1 <- auto.arima(ur.ts, xreg = cbind(gdp.ts))
summary(reg1)
fore <- forecast(reg1, xreg = cbind(gdp.ts))
plot(fore, xlim = c(2001, 2023), xlab = "Year", ylab = "Unemployment rate", main = "Unemployment rate Forecasting")
lines(reg1$fitted, col="blue")
grid()

# Fit model with validation period
nValid <- 18
nTrain <- length(ur.ts) - nValid
train.ts <- window(ur.ts, start = c(2000, 1), end = c(2000, nTrain))
valid.ts <- window(ur.ts, start = c(2000, nTrain+1), end = c(2000, nTrain+nValid))

arima.fit <- auto.arima(train.ts)


#2018
dta2 <- read.csv("/Users/blue/Desktop/Forecasting/finalproject_forecasting/US-unemploymentrate(1).csv")
ur.ts1 <- ts(dta2$US.UnemploymentRate, frequency = 12, start = c(2018,1))
plot(ur.ts1, xlim = c(2018, 2021), xlab = "Year", ylab = "ur ", main = "ur")

reg3 <- auto.arima(ur.ts1)
fore <- forecast(reg3)
plot(fore, xlim = c(2018, 2023), xlab = "Year", ylab = "Unemployment rate", main = "Unemployment Rate Forecasting")
lines(reg3$fitted, col="blue")
lines(ur.ts1)
grid()

#2010
dta3 <- read.csv("/Users/blue/Desktop/Forecasting/finalproject_forecasting/ds3.xlsx")
ur.ts2 <- ts(dta3$US.UnemploymentRate, frequency = 12, start = c(2010,1))
plot(ur.ts2, xlim = c(2010, 2021), xlab = "Year", ylab = "ur ", main = "ur")

reg4 <- auto.arima(ur.ts2)
fore <- forecast(reg4)
plot(fore, xlim = c(2010, 2023), xlab = "Year", ylab = "Unemployment rate", main = "Unemployment Rate Forecasting")
lines(reg4$fitted, col="blue")
lines(ur.ts2)
grid()

#VAR
df.ur <- ur.df(ur.ts, type = "trend", selectlags = "AIC")
summary(df.ur)

df.sp500 <- ur.df(sp500.ts, type = "trend", selectlags = "AIC")
summary(df.sp500)
ChangeUR <- diff(ur.ts, lag = 1)
ChangeSP500 <- diff(sp500.ts, lag = 1)
df.sp500_diff <- ur.df(ChangeSP500, type = "trend", selectlags = "AIC")
summary(df.sp500_diff)

data <- cbind(ChangeUR, ChangeSP500)
names <- c("Unemployment Rate", "S&P 500")
colnames(data) <- names
plot(data, main = "Unemployment Rate and S&P 500")

grangertest(ChangeUR ~ ChangeSP500, order = 3, data = data)

lagselect <- VARselect(data, lag.max = 10, type = "const")    #  Use to select optimal number of lags
lagselect$selection

model.1 <- VAR(data, p = 3, type = "const")    #  Use to fit VAR model
summary(model.1)  

#serial.test(model.1, lags.pt=10, type="PT.asymptotic")
irplot <- irf(model.1,n.ahead=24,ortho=FALSE)
plot(irplot)
forecast1 <-forecast(model.1)
forecast1 <-predict(model.1, n.ahead = 25, ci = 0.95)
plot(forecast1,xlab="Year")
model.1$varresult
