
# Background and Focus
In 2020, COVID-19 made a negative impact on unemployment rate. As the epidemic is gradually controlled, we aim to analyze and forecast how unemployment rate will change in future years. 

# Data Sources
We dowload the close price of S&P 500 from the Yahoo Finance website, ranging from 2000.1 to 2021.8. We also used The U.S GDP data and Inflation Rate data and Government benefits data to support analysis.

# Data Cleaning
We removed outliars in the orignal data.

# Modeling
The ARIMA model (autoregressive integrated moving average model) is one that directly models the autocorrelation of the series values as well as the autocorrelations of the forecasting errors. Here we select ARIMA as our model

![plot](https://github.com/Bluebai22/MoviePreference/blob/main/Github/ARIMA1.png)
![plot](https://github.com/Bluebai22/MoviePreference/blob/main/Github/ARIMA2.png)

# Model explaining
It can observed from this figure that the parameters of auto ARIMA function is ARIMA(1,1,1)(0,0,2), which indicates it uses both ARIMA and seasonal ARIMA function. For the parameters in ARIMA function, p=1 means the number of AR terms is 1; d=1 means the difference of trend is once; q=1 means the number of moving average is 1. For the parameters in seasonal ARIMA function, only q equals to 2 which means the moving average is 2.

