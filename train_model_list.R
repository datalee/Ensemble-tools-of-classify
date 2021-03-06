train_model_list <- function(container, algorithm=c("SVM","SLDA","BOOSTING","BAGGING","RF","GLMNET","TREE","NNET","MAXENT"), ...) {
  
  # CLEAN UP FROM PREVIOUS MODEL TRAINED
  gc()
  
  # CONDITIONAL TRAINING OF MODEL
  if (algorithm=="SVM") {
    model <- svm(x=container[1][[1]], y=as.factor(container[2][[1]]), probability=TRUE, ...)
  } else if (algorithm=="SLDA") {
    model <- slda(as.factor(container[2][[1]]) ~ ., data=data.frame(as.matrix(container[1][[1]])), ...)
  } else if (algorithm=="BOOSTING") {
    model <- LogitBoost(xlearn=as.matrix(container[1][[1]]), ylearn=container[2][[1]], ...)
  } else if (algorithm=="BAGGING") {
    model <- bagging(as.factor(container[2][[1]]) ~ ., data=data.frame(as.matrix(container[1][[1]])), ...)
  } else if (algorithm=="RF") {
    model <- randomForest(x=as.matrix(container[1][[1]]), y=as.factor(container[2][[1]]), ...)
  } else if (algorithm=="GLMNET") {
    training_matrix <- as(container[1][[1]],"sparseMatrix")
    model <- glmnet(x=training_matrix, y=container[2][[1]], family="multinomial", ...)
  } else if (algorithm=="TREE") {
    model <- tree(as.factor(container[2][[1]]) ~ ., data=data.frame(as.matrix(container[1][[1]])), ...)
  } else if (algorithm=="NNET") {
    model <- nnet(container[2][[1]] ~ ., data=data.frame(as.matrix(container[1][[1]])), ...)
  } else if (algorithm=="MAXENT") {
    model <- maxent(container[1][[1]],as.vector(container[2][[1]]), ...)
  } else {
    stop("ERROR: Invalid algorithm specified. Type print_algorithms() for a list of available algorithms.container is list(traindata,lable)")
  }
  
  # RETURN TRAINED MODEL
  gc() # CLEAN UP AFTER MODEL
  return(model)
}