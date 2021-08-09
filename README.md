# MULTIPLE-REGRESSION-MODEL-FOR-PREDICTING-GDP-USING-MACROECONOMIC-VARIABLES-PART-2
Lasso Regression - Machine Learning Approach
## Introduction
Fortunately, the capability to use machine learning (ML) algorithms to detect patterns associated with variables that drive business has made it very useful in predicting the risk factors related to business decisions. Our interest is to identify and evaluate the impact of macroeconomic variables on GDP. This part of the project focus on using a machine learning approach to predict GDP using macroeconomic variables. It is a continuation of Part 1, where we predicted the GDP with six predictors using a multiple linear regression model, added two new macroeconomic variables to observe the sensitivity of each on the base model fit in terms of p-values, r-square and adjusted r-square. The Variance Inflation factor (VIF) observed showed some level of multicollinearity based on the threshold (VIF >2) set for the research. Therefore, in this session, we are interested in using a regularized regression model (Lasso Regression), a machine learning approach to handle this. Lasso regression adds a shrinkage penalty to the residual sum of squares that removes some predictor variables by forcing their regression coefficients to zero because of multicollinearity. The random forest technique mainly does feature selection just like the Lasso model but we are more interested in both explanation and prediction of the the observed macroeconomic variables.  
## Data Processing

Data: Macroeconomic Variables (U.S. Bureau of Economic Analysis)

Source: https://fred.stlouisfed.org/series (Variables merged into an excel sheet – converted to Annual Percent: 28 columns and 272 rows).

After splitting the dataset into a train (70%) and test (30%), the missing values are treated separately by imputation using the “mice package” in R. A data frame is created for the missing values, and then the “mice package” imputed the missing data to ensure there was no longer any missing data (see R-code).
Measurement:
Dependent Variable: Gross Domestic Product (GDP) – Annual Percent(GDP.AP) 
Independent Variables: Population Rate (POPTHM) – Annual Percent (POPTHM.AP)
			Interest Rate (INTDSRUSM193) – Annual Percent (INTDSRUSM193.AP)
			10-Year Treasury Constant Maturity Rate (DGS10) – Annual Percent (DGS10.AP)
			Unemployment Rate (U2RATE) – Annual Percent (U2RATE.AP)
			All Transactions House price Index (USSTHPI) – Annual Percent (USSTHPI.AP)
			Corporate Profit After Tax (CP) – Annual Percent(CP.AP)
			10-Year Breakeven Inflation Rate (T10YIE) – Annual Percent (T10YIE.AP)
Feature Selection
The independent variables or predictors consist of other macroeconomic variables, namely population rate, interest rate, treasury constant maturity rate, unemployment rate, house price index, corporate profit, and inflation rate, while the dependent variable is the gross domestic product which has all been transformed to annual percentage terms.
