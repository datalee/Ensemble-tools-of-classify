data("iris")
iris.data <- iris

iris.label <- as.numeric(iris.data$Species)
iris.data <- as.matrix(iris.data[,-5])
# iris.xgb_DMatrix <- xgb.DMatrix(data = iris.data, label=iris.label) #matrix

iris.train <- list(iris.data,iris.label)

# 
# library(RTextTools)
# model <- svm(x=iris.train[1][[1]], y=as.factor(iris.train[2][[1]]), probability=TRUE)
# library(ipred)
# model <- slda(as.factor(iris.train[2][[1]]) ~ ., data=data.frame(as.matrix(iris.train[1][[1]]),iris.train[2][[1]]))
# 
# model <- train_model_list(iris.train,algorithms="RF")
library(maxent)
library(glmnet)
library(tree)
library(nnet)
library(e1071)
library(ipred)
library(caTools)
library(Matrix)
library(randomForest)
models <- train_models_list(iris.train, algorithms=c("MAXENT","SVM","GLMNET","SLDA","TREE","BAGGING","BOOSTING","RF"))
results <- classify_models_list(iris.train,models)
# model <- models[['SLDA']]
# 
# # result <- classify_model_list(iris.train,model)
# # svm_results <- predict(model,as.matrix(iris.train[1][[1]]), probability=TRUE)
# # svm_pred <- svm_results[1:length(svm_results)]
# # svm_prob <- apply(attr(svm_results,"probabilities"),1,extract_maximum_prob)
# result <- classify_model_list(iris.train,models[['BAGGING']])
# slda_results <- predict(models[['SLDA']],data.frame(iris.train[1][[1]]))
scoreSummary <- create_scoreSummary_list(iris.train,results)

algorithm_summary <- as.data.frame(create_precisionRecallSummary_list(iris.train, results, 1))