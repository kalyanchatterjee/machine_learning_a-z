# Polynomial Regression

setwd("~/Desktop/machine_learning_a-z/Part 2 - Regression/Section 6 - Polynomial Regression/Polynomial_Regression")

# Importing the dataset
dataset <- read.csv('Position_Salaries.csv')
dataset <- dataset[2:3]

# NOT creating a training set and a test set as the dataset is very small

# Splitting the dataset into the Training set and Test set
# # install.packages('caTools')
# library(caTools)
# set.seed(123)
# split = sample.split(dataset$Salary, SplitRatio = 2/3)
# training_set = subset(dataset, split == TRUE)
# test_set = subset(dataset, split == FALSE)

# Feature Scaling
# training_set = scale(training_set)
# test_set = scale(test_set)

# Fitting Linear Regression to dataset
lin_reg <- lm(formula = Salary ~ ., data = dataset)
summary(lin_reg)

# Visualizing the Linear Regression results
library(ggplot2)
ggplot() + 
  geom_point(aes(x = dataset$Level, y = dataset$Salary),
             color = 'red') + 
  geom_line(aes(x = dataset$Level, y = predict(lin_reg, newdata = dataset)),
            color = 'blue') + 
  ggtitle('Truth or Bluff (Linear Regression') + 
  xlab('Level') + 
  ylab('Salary')

# Fitting Polynomial Regression to dataset
# Introduce new columns 
dataset$Level2 <- dataset$Level^2
dataset$Level3 <- dataset$Level^3
dataset$Level4 <- dataset$Level^4
# dataset$LevelN <- dataset$Level^N
poly_reg <- lm(formula = Salary ~ ., data = dataset)
summary(poly_reg)

# Visualizing the Polynomial Regression results
ggplot() + 
  geom_point(aes(x = dataset$Level, y = dataset$Salary),
             color = 'red') + 
  geom_line(aes(x = dataset$Level, y = predict(poly_reg, newdata = dataset)),
            color = 'blue') + 
  ggtitle('Truth or Bluff (Polynomial Regression') + 
  xlab('Level') + 
  ylab('Salary')

# Predicting a new result with Linear Regression
y_pred <- predict(lin_reg, data.frame(Level = 6.5))

# Predicting a new result with Polynomial Regression
y_pred <- predict(poly_reg, data.frame(Level = 6.5,
                                       Level2 = 6.5^2,
                                       Level3 = 6.5^3,
                                       Level4 = 6.5^4))

# Question - Why don't we keep on increasing the order of the polynomial? 

























