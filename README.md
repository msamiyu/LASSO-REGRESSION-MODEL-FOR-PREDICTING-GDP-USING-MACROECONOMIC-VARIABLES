# MULTIPLE-REGRESSION-MODEL-FOR-PREDICTING-GDP-USING-MACROECONOMIC-VARIABLES-PART-2
Lasso Regression - Machine Learning Approach
## Introduction
Fortunately, the capability to use machine learning (ML) algorithms to detect patterns associated with variables that drive business has made it very useful in predicting the risk factors related to business decisions. Our interest is to identify and evaluate the impact of macroeconomic variables on GDP. This part of the project focus on using a machine learning approach to predict GDP using macroeconomic variables. It is a continuation of https://github.com/msamiyu/MULTIPLE-REGRESSION-MODEL-FOR-PREDICTING-GDP-USING-MACROECONOMIC-VARIABLES-PART-1, where we predicted the GDP with six predictors using a multiple linear regression model, added two new macroeconomic variables to observe the sensitivity of each on the base model fit in terms of p-values, r-square and adjusted r-square. The Variance Inflation factor (VIF) observed showed some level of multicollinearity based on the threshold (VIF >2) set for the research. Therefore, in this session, we are interested in using a regularized regression model (Lasso Regression), a machine learning approach to handle this. Lasso regression adds a shrinkage penalty to the residual sum of squares that removes some predictor variables by forcing their regression coefficients to zero because of multicollinearity. The random forest technique mainly does feature selection just like the Lasso model, but we are more interested in both explanation and prediction of the observed macroeconomic variables.  
## Data Processing

Data: Macroeconomic Variables (U.S. Bureau of Economic Analysis)

Source: https://fred.stlouisfed.org/series (Variables merged into an excel sheet – converted to Annual Percent: 28 columns and 272 rows).

After splitting the dataset into a train (70%) and test (30%), the missing values are treated separately by imputation using the “mice package” in R. A data frame is created for the missing values, and then the “mice package” imputed the missing data to ensure there was no longer any missing data (see R-code).

## Measurement:
Dependent Variable: Gross Domestic Product (GDP) – Annual Percent(GDP.AP) 
Independent Variables: Population Rate (POPTHM) – Annual Percent (POPTHM.AP)
			Interest Rate (INTDSRUSM193) – Annual Percent (INTDSRUSM193.AP)
			10-Year Treasury Constant Maturity Rate (DGS10) – Annual Percent (DGS10.AP)
			Unemployment Rate (U2RATE) – Annual Percent (U2RATE.AP)
			All Transactions House price Index (USSTHPI) – Annual Percent (USSTHPI.AP)
			Corporate Profit After Tax (CP) – Annual Percent(CP.AP)
			10-Year Breakeven Inflation Rate (T10YIE) – Annual Percent (T10YIE.AP)

## Feature Selection
The independent variables or predictors consist of other macroeconomic variables, namely population rate, interest rate, treasury constant maturity rate, unemployment rate, house price index, corporate profit, and inflation rate, while the dependent variable is the gross domestic product which has all been transformed to annual percentage terms.

Model: 

The Lasso regression model is of the form;

![image](https://user-images.githubusercontent.com/54149747/128662755-5a09440f-8547-48cd-990a-83e4f6d80b81.png)         (1)

   **Note:**
   
    * The hyperparameter λ is tuned to get the optimal lambda value which is used to build the Lasso regression model
    
    * The “glmnet” library used in R to compute the optimal lambda uses alpha by default to represent lambda in (1) above. 

    * For Lasso regression, alpha is set as 1 for the “glmnet” library computation purpose.
 
**Model Validation:**

**Cross-Validation (CV):** The dataset is split into train Set (70% of original data) and test Set (30%). The model was trained on the training set and then tested on the test set. 
To ensure that every observation/record in the original dataset can appear in the train and test set, we apply K-Fold CV.  

**Model performance:** The performance of the model shall be based on the following metrics:

**R-Square** – It is a relative measure of fit that shows how variance in the model corresponds to the total variance. A higher R-Square indicates a better fit for our regression model.
**RMSE**(Root Mean Square Error) –  It is an absolute measure of fit that shows the standard deviation of the variance not explained by the model. A lower RMSE indicates a better fit for our regression model.

## Result

**Optimal lambda:** After performing 10-folds cross validation on the train-data, the optimal lambda value obtained that minimizes the mean-square error (MSE) is;

![image](https://user-images.githubusercontent.com/54149747/128663226-0070f89f-a3b7-4c94-a9f0-e3adb9d11741.png)

The plot of train MSE by the optimal value is shown below;

![image](https://user-images.githubusercontent.com/54149747/128663268-4462f94c-af9f-4d3e-81d0-f80487deb857.png)

**Important independent variables:**  The output below shows the independent variables that are more important for prediction (values displayed) and those whose coefficients would be shrunk, and the Lasso model will remove their predictors. The output shows that the interest rate (INTDSRUSM193) and the inflation rate (T10YIE) variables are shrunk and removed by the Lasso model.

![image](https://user-images.githubusercontent.com/54149747/128663328-be92845a-3023-4bfe-9d0f-22ed907c0f69.png)

**Model performance:** 

**Train Data:**

![image](https://user-images.githubusercontent.com/54149747/128663350-c8455568-ed42-4cfa-9786-3c07ef0721ae.png)

From the output above, the r-square (88.8%) shows that about 89% of our trained macroeconomic data fits the Lasso regression model. While the RMSE (0.0114) indicates that        about 1.1% of variance is not explained by our model.

**Test Data:**

![image](https://user-images.githubusercontent.com/54149747/128663391-d03d0a74-9039-4ebe-a87d-4a1fbf06d78a.png)

From the output above, the r-square (73.2%) shows that about 73% of our test macroeconomic data fits the Lasso regression model. While the RMSE (0.018) indicates that about      1.2% of variance is not explained by our model.

**Conclusion**

In this short essay, we examined how GDP could be predicted using other macroeconomic variables. To achieve this objective, we used the Lasso regression technique to extend the model developed in Part1 of this essay when we evaluated how each additional variable impacted our regression fit by comparing the VIF’s and the p-values at a 5% significant level. The Lasso regression model appears to be a suitable regularization technique that helps overcome the multicollinearity effect in the linear regression base model by forcing some parameters to zero and help us with feature selection. The r-squared obtained seems more reliable, and the RMSE for both train and test data gave a minimal prediction error. It also prevents overfitting that might have occurred in the regression model output. In contrast, the machine learning approach helps in prediction accuracy.

**References**

•	FRED Economic Data: https://fred.stlouisfed.org/series

•	Deepika Singh: https://www.pluralsight.com/guides/linear-lasso-and-ridge-regression-with-r




