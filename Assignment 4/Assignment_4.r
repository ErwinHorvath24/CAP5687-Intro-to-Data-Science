# Load dataset library
GlobalAncestry <- read_csv("Homework #4/GlobalAncestry.csv")

# Training Set
train <- GlobalAncestry %>%
  filter(ancestry %in% c("African", "EastAsian","European", "NativeAmerican", "Oceanian"))

# Test Set
test <- GlobalAncestry %>%
  filter(ancestry %in% c("Unknown1", "Unknown2", "Unknown3", "Unknown4", "Unknown5"))

# Training Set of X & Y
Y<-train %>% select(ancestry) %>% as.matrix()
X<-train %>% select(pos1:pos8916) %>% as.matrix()

# Tuning Parameter
lambdas<- 10^seq(-3,3, length.out=100)

# Training a Lasso-Penalized Multinonmial Regression Classifier 
lasso.fit <- glmnet(X,Y, family = "multinomial", alpha=1, lambda=lambdas)

# Plot Lasso.fit
plot(lasso.fit, xvar = "lambda")

# Determining the cross-validation error as a function of log(lambda)
lasso.cv <- cv.glmnet(X, Y, family = "multinomial", alpha = 1, lambda = lambdas, nfolds = 10)
plot(lasso.cv)

#Determining the best lambda value
lasso.best <- glmnet(X, Y, family = "multinomial", alpha = 1,lambda = lasso.cv$lambda.min)
lasso.best # Best Lambda

# Determining the Simplest model within 1 SE 
lasso.1se <- glmnet(X, Y, family = "multinomial", alpha = 1,lambda = lasso.cv$lambda.1se)
lasso.1se # Simplest model within 1 SE

# Training a Lasso-Penalized Regression Classifier on lambda 1se
lasso.1se <- glmnet(X, Y, family = "multinomial", alpha = 1,lambda = lasso.cv$lambda.1se)

# Prediction and new data 
estClass <- predict(lasso.1se, X, type = "class", s = lasso.cv$lambda.1se)
train.withPreds <- train %>%
  mutate(pred = c(estClass))

# Confusion Matrix 
train.withPreds %>%
  select(ancestry, pred) %>%
  table() 

#Training Accuracy 
train.withPreds %>%
  summarize(accuracy = mean(pred == ancestry))
  
# Test Set X & Y
Ytest<-test %>% select(ancestry) %>% as.matrix()
Xtest<-test %>% select(pos1:pos8916) %>% as.matrix()

# Prediction and new data 
estClassTest <- predict(lasso.1se, Xtest, type = "class", s = lasso.cv$lambda.1se)
test.withPreds <- test %>%
  mutate(pred = c(estClassTest))
head(estClass1)




