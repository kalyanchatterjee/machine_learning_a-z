# Data Preprocessing Template

# set working directory
setwd('/users/chatterjee/Desktop/Machine Learning A-Z/Part 1 - Data Preprocessing')

# Importing the dataset
dataset = read.csv('Data.csv')

# Taking care of the missing data
dataset$Age = ifelse(is.na(dataset$Age),
                     ave(dataset$Age, FUN = function(x) mean(x, na.rm = TRUE)),
                     dataset$Age)

dataset$Salary = ifelse(is.na(dataset$Salary),
                        ave(dataset$Salary, FUN = function(x) mean(x, na.rm = TRUE)),
                        dataset$Salary)

# Encoding categorical data
dataset$Country = factor(dataset$Country,
                         levels = c('France', 'Spain', 'Germany'),
                         labels = c(1, 2, 3))

dataset$Purchased = factor(dataset$Purchased,
                           levels = c('Yes', 'No'),
                           labels = c(0, 1))

# Splitting the data into training set and test set
# install.packages('caTools')
library(caTools)
set.seed(123)
# Split the data into training set and test set
# Here dataset$Purchased is the dependent variable 
# SplitRatio = the percentage you want to be the training set
split <- sample.split(dataset$Purchased, SplitRatio = 0.8)
# What will split return? 
# It will return a logical vector with the same length as the number of data point
# It will be TRUE if the data point was chosen to be part of the training set or FALSE
# if it was chosen to be part of the test set
training_set <- subset(dataset, split == TRUE)
test_set <- subset(dataset, split == FALSE)

# Feature Scaling
# It is necessary to scale the training_set and the test_set, becuase if we look
# at the Euclidian distances between any two points (age, salary), the square
# of the difference of salary dominates over the square of the difference in
# age. Only scaling the age and salary columns
training_set[2:3] = scale(training_set[2:3])
test_set[2:3] = scale(test_set[2:3])
