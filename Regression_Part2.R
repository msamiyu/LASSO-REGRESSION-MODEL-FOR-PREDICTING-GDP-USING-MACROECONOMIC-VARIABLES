#Set work directory
setwd("C:/Users/19312/Desktop/cran")
data<-read.csv("GDP.CFRM.csv",header=TRUE,sep = ",")
head(data)
set.seed(1000) #To ensure reproducibility
#Train-Test Split
train_data <- sample(1:nrow(data), 0.7*nrow(data)) #70% split
train_split<- data[train_data,] #contains 70% of data
test_split <-data[-train_data,] #contains 30% of data
dim(train_split)
dim(test_split)
#Handle the missing values Train-set
missing <- train_split[c("GDP.AP", "POPTHM.AP", "INTDSRUSM193.AP", "DGS10.AP","DSPI.AP","U2RATE.AP","USSTHPI.AP","CP.AP","T10YIE.AP")]
summary(missing)
str(missing)
set.seed(4000) #To ensure reproducibility(not necessary)
#Perform the imputation on the missing data
library(mice)
imputed = complete(mice(missing))
summary(imputed)
#filling the original dataframe with the imputed data
train_split$GDP.AP = imputed$GDP.AP
train_split$POPTHM.AP = imputed$POPTHM.AP
train_split$INTDSRUSM193.AP = imputed$INTDSRUSM193.AP
train_split$DGS10.AP = imputed$DGS10.AP
train_split$DSPI.AP = imputed$DSPI.AP
train_split$U2RATE.AP = imputed$U2RATE.AP
train_split$USSTHPI.AP = imputed$USSTHPI.AP
train_split$CP.AP = imputed$CP.AP
train_split$T10YIE.AP = imputed$T10YIE.AP
summary(train_split) #To ensure we no longer have missing values
#Scaling the train and test dataset
install.packages("caret")
library(caret)
feat<- c('POPTHM.AP', 'INTDSRUSM193.AP', 'DGS10.AP','DSPI.AP','U2RATE.AP','USSTHPI.AP','CP.AP','T10YIE.AP')
pre_proc <- preProcess(train_split[,feat], method = c("center", "scale"))
train_split[,feat]<- predict(pre_proc, train_split[,feat])
test_split[,feat] <- predict(pre_proc, test_split[,feat])
summary(train_split)
#creating a numeric matrix for the trainin_split
data_col<- c('GDP.AP', 'POPTHM.AP', 'INTDSRUSM193.AP', 'DGS10.AP','DSPI.AP','U2RATE.AP','USSTHPI.AP','CP.AP','T10YIE.AP')
dummy_data<- dummyVars(GDP.AP~.,data=data[,data_col])
dummy_train<- predict(dummy_data, newdata = train_split[,data_col])
dummy_test<- predict(dummy_data, newdata = test_split[,data_col])
dim(dummy_train) #dimension of train data matrix
dim(dummy_test)  #dimension of test data matrix
x_train <- as.matrix(dummy_train)
y_train <-train_split$GDP.AP
#Finding the optimal Lambda that minimize MSE
lambda_seq<- 10^seq(2, -3, by = -.1)
#performing 10 folds cross validation and setting alpha=1 for Lasso regression
library(glmnet)
cv_model <- cv.glmnet(x_train, y_train, alpha = 1, lambda = lambda_seq, standardize = TRUE, nfolds = 10)
plot(cv_model)
opt_lambda <- cv_model$lambda.min  #optimal lambda value
opt_lambda
#prediction and coefficients of best model(Lasso)
best_model<-glmnet(x_train, y_train, alpha = 1, lambda = opt_lambda, standardize = TRUE)
#To see the predictors whose coefficient will be shrunk by the Lasso model
coef(best_model)
#Predictions
#Model Performance Metrics
#For Train Data
train_pred <- predict(best_model, s = opt_lambda, newx = x_train)
head(train_pred)
rss<- sum((train_pred - y_train)^2)    #residual sum of square
tss <- sum((y_train - mean(y_train))^2)  #total sum of square
r_square <- 1 - rss /tss #R-Square
rmse <- RMSE(train_pred, y_train)  #Root mean Square Error
cbind(r_square, rmse)
#For Test Data
#Handle the missing values Train-set
missing1 <- test_split[c("GDP.AP", "POPTHM.AP", "INTDSRUSM193.AP", "DGS10.AP","DSPI.AP","U2RATE.AP","USSTHPI.AP","CP.AP","T10YIE.AP")]
summary(missing1)
str(missing1)
set.seed(3000) #To ensure reproducibility(not necessary)
#Perform the imputation on the missing data
library(mice)
imputed1 = complete(mice(missing1))
summary(imputed1)
#filling the original dataframe with the imputed data
test_split$GDP.AP = imputed1$GDP.AP
test_split$POPTHM.AP = imputed1$POPTHM.AP
test_split$INTDSRUSM193.AP = imputed1$INTDSRUSM193.AP
test_split$DGS10.AP = imputed1$DGS10.AP
test_split$DSPI.AP = imputed1$DSPI.AP
test_split$U2RATE.AP = imputed1$U2RATE.AP
test_split$USSTHPI.AP = imputed1$USSTHPI.AP
test_split$CP.AP = imputed1$CP.AP
test_split$T10YIE.AP = imputed1$T10YIE.AP
summary(test_split) #To ensure we no longer have missing values
x_test <- as.matrix(dummy_test)
y_test <- test_split$GDP.AP
test_pred <- predict(best_model, s = opt_lambda, newx = x_test)
head(test_pred)
rss1<- sum((test_pred - y_test)^2, na.rm = TRUE)    #residual sum of square
tss1<- sum((y_test - mean(y_test))^2)  #total sum of square
r_square1 <- 1 - rss1 /tss1 #R-Square
rmse1 <- RMSE(test_pred, y_test, na.rm = TRUE)  #Root mean Square Error
cbind(r_square1,rmse1)
