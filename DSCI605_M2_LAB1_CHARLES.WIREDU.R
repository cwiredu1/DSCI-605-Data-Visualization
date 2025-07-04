getwd()
setwd("~/Desktop/Data science Assignments")

install.packages("ggplot2")
install.packages("tidyverse")
library(ggplot2)
library(tidyverse)

##read the dataset
library(readr)
Soil_Organic_Carbon <- read_csv("~/Downloads/Soil Organic Carbon.csv")
View(Soil_Organic_Carbon)
DF <- Soil_Organic_Carbon

## choose the variable you want to make histogram for
SOC_data <- as.numeric((DF$`10-20cm`))
View(SOC_data)

## Histogram for the  chosen data
hist(SOC_data)

## Make some adjustments, set title, X and Y axes, ylim,bin, label direction
hist(SOC_data,
     main="Histogram for SOC at 10-20cm",
     xlab="Soil_Organic_Carbon",
     xlim=c(0,7),
     col="darkmagenta",
     las= 1,
     breaks = 8)

## when border is added to the coding with color changed
hist(SOC_data,
     main="Histogram for SOC at 10-20cm",
     xlab="Soil_Organic_Carbon",
     border = "blue",
     xlim=c(0,8),
     col="green",
     las= 1,
     breaks = 10,
     prob = TRUE)

## Histogram with ggplot in ggplot2
ggplot(data= NULL, aes(SOC_data)) + 
  geom_histogram()

# Histogram with bin width and bin size
ggplot(data= NULL, aes(SOC_data)) + 
  labs(title= "Histogram for SOC @ 10-20cm", x= "Soil_Organic_Carbon", y= "count")+
  geom_histogram(colour = 4, fill = "white", 
                 binwidth = 0.5)

##bin size added to our histogram
ggplot(data= NULL, aes(SOC_data)) + 
  labs(title= "Histogram for SOC @ 10-20cm", x= "Soil_Organic_Carbon", y= "count of values")+
  geom_histogram(colour = 4, fill ="yellow",
                 binwidth =0.8, bins = 10)


SOC_long1 <- as.numeric(c(DF$`0-5cm`,DF$`5-10cm`,DF$`10-20cm`,DF$`20-30cm`))
View(SOC_long1)

hist(SOC_long1)



#plot two histograms in same graph
X1<-as.numeric(DF$`0-5cm`)

X2 <- as.numeric(DF$`5-10cm`)
hist(X1, col=rgb(0,0,1,0.2), xlim=c(0, 8),
     xlab='Soil_Organic_Carbon', ylab='Count Values', main='Histogram for SOC at 0-5cm&5-10cm')
hist(X2, col=rgb(1,0,0,0.2), add=TRUE)

#add legend
legend('topright', c('0-5cm', '5-10cm'),
       fill=c(rgb(0,0,1,0.2), rgb(1,0,0,0.2)))
