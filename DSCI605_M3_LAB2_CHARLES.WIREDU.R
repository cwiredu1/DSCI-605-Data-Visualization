setwd("C:/Users/owner/Desktop/Data Science")
library(readr)
Salaries <- read_csv("C:/Users/owner/Desktop/Salaries.csv")
View(Salaries)

### create a 10 by 10 matrix in R.
df <- matrix(1:100, nrow = 10, ncol = 10)
View(df)
df
## column and row means
colMeans(df)

rowMeans(df)

### for row and column standard deviation

install.packages("matrixStats")
library(matrixStats)

colstd <- colSds(df)
colstd

row_std <- rowSds(df)
row_std

##one variable to calculate the mean, median, mode and maximum value for that variable from dataset
years_service <- Salaries$yrs.service

## mean of variable
mean(years_service)

## median of variable
median(years_service)

##maximum value of variable
max(years_service)

##mode of variable
mode(years_service)
install.packages("modeest")
library(modeest)
mfv(years_service)
