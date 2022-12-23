
# Background and Focus
In 2020, COVID-19 made a negative impact on unemployment rate. As the epidemic is gradually controlled, we aim to analyze and forecast how unemployment rate will change in future years. 

# Data Sources
We dowload the close price of S&P 500 from the Yahoo Finance website, ranging from 2000.1 to 2021.8. We also used The U.S GDP data and Inflation Rate data and Government benefits data to support analysis.

# Data Cleaning
We removed outliars in the orignal data.

# Modeling with ARIMA
The ARIMA model (autoregressive integrated moving average model) is one that directly models the autocorrelation of the series values as well as the autocorrelations of the forecasting errors.

![plot](https://github.com/Bluebai22/MoviePreference/blob/main/Github/ARIMA1.png)
![plot](https://github.com/Bluebai22/MoviePreference/blob/main/Github/ARIMA2.png)

# ARIMA Model explaining
It can observed from this figure that the parameters of auto ARIMA function is ARIMA(1,1,1)(0,0,2), which indicates it uses both ARIMA and seasonal ARIMA function. For the parameters in ARIMA function, p=1 means the number of AR terms is 1; d=1 means the difference of trend is once; q=1 means the number of moving average is 1. For the parameters in seasonal ARIMA function, only q equals to 2 which means the moving average is 2.

# Modeling with Vector Autoregressions(VAR) model
Forecast the unemployment rate of U.S. with the close price of S&P 500

STEP1: Test stationary using Dickey Fuller Tests for both data. Since p value of z.lag.1 is bigger than 0.05, time series is not stationary.

STEP2: Take difference of both data to make them stationary. 

STEP 3: Combine two data into one dataset.

STEP 4: Select lags 3 with model order selection method

STEP 5: Check whether S.P. 500 granger causes Unemployment rate with granger test.
P value < 0.05, reject the null hypothesis. S&P 500 granger cause unemployment rate 

STEP 6: Estimate VAR model with lag 3 (SC/BIC selected) and forecast with VAR(3) model.
Conclusion: Unemployment rate will go steady and change in the range of 2% and S&P 500 will change in the range of about 100 dollars at 95% confidence level in further 2 years.
![plot](https://github.com/Bluebai22/MoviePreference/blob/main/Github/VAR.png)

