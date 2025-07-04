setwd("~/Desktop/Data science Assignments")

###install required packages for PCA 
install.packages("FactoMineR")
install.packages("factoextra")
library("FactoMineR")
library("factoextra")
install.packages("ggplot2")
library("ggplot2")
###Principal component analysis in R

##load dataset and subsetting the first column
library(readr)
Samples_1 <- read_csv("~/Desktop/Samples-1.csv")
View(Samples_1)

new_sample1 <- data.frame(Samples_1[,-1], row.names= Samples_1$Sites)
View(new_sample1)
head(new_sample1[,1:6], 4)

##data description
summary(new_sample1 )

res.pca <- PCA(new_sample1,scale.unit= TRUE, graph = FALSE)
print(res.pca)
##The code below computes principal component analysis on the active individuals and variables
## the output of the function is a list, including the following components

eig.val <- get_eigenvalue(res.pca )
eig.val
##extracting the eigenvalues/variance of principal components
## the eigenvalues measures the amount of variation retained by each principal components
## they are usually large for the first PCs. That is, the first PCs correspond to the directions with 
## maximum amount of variation in the data set
##the sum of all the eigenvalues give a total 7.0. the proportion of vraition explianed by each eigenvalue 
#is given in the second column. For example 3.96 divided by 6.97 equals 56.64% of the variation 
#explained by the first eigenvalue. The commulative percentages explianed is obtained by ading the successive proportions of variation
# explained to obtain the running total. for example 85.90% is explained by the two eigenvalues
#together.

fviz_eig(res.pca,addlabels = TRUE,ylim= c(0,60))
## the scree plot is an alternative method to determine the number of principal components.This
## is a plot eigenvalues ordered from largest to the smallest. The number of components is determined 
# at the point,beyond which othereigenvalues are relatively small.


###the use of this function in principal component analysis list all the matrices containing all the results 
## for the active variables(coordinates,correlation,squared cosine and contributions)
var<- get_pca_var(res.pca)
var


###The different components can be assesed as follows:
##cordinates
head(var$coord)
##cor: correlation between variable and dimension
head(var$cor)
## cos2; quality on the factore map
head(var$cos2)
##contribution to principal components
head(var$contrib)
head(var$coord,3)

###ploting of variables
plot1<-fviz_pca_var(res.pca,col.var= "blue")
plot1

plot2<-fviz_pca_var(res.pca,pointsize="cos2", pointshape= 21,repel="True",fill="black")
plot2

plot3<-fviz_pca_var(res.pca,pointsize="cos2", col.var = "cos2",
                    gradient.cols= c("#00AFBB","#E7B800", "#FC4E07"),
                    repel= TRUE) 
plot3

fviz_pca_var(res.pca,pointsize="contrib", col.var = "contrib",
             gradient.cols= c("#00AFBB","#E7B800", "#FC4E07"),
             repel= TRUE) 

fviz_pca_var(res.pca,pointsize="coord", col.var = "coord",
             gradient.cols= c("#00AFBB","#E7B800", "#FC4E07"),
             repel= TRUE) 


## the plot above also known as variable correlation plot shows the relationships between all variables.
## it can be interpreted as 
#positively correlated variables are grouped together
#negatively correlated varaibles are positioned on opposite sides of he plot
# the quality of the variables is measured by the distance between the variables and the origin

###ploting of individuals- quality and contribution
ind<- get_pca_ind(res.pca)
ind


head(ind$coord)# coordinates of individuals
head(ind$cor)# correlation between individuals and dimension
head(ind$cos2)#quality of individuals
head(ind$contrib)#contribution of the individuals

graph1<-fviz_pca_ind(res.pca)
graph1

graph2<-fviz_pca_ind(res.pca, col.ind = "cos2",
                     gradient.cols= c("#00AFBB","#E7B800", "#FC4E07"),
                     repel= TRUE)
graph2

##plot of quality representation of cos2
fviz_cos2(res.pca, choice= "ind", axes =1:2)

## plot of contribution of individuals to first two dimensions

fviz_contrib(res.pca, choice= "ind", axes =1:2)

##corrlation matrix graph
install.packages("corrplot")
library("corrplot")

corrplot(var$cos2, method= 'ellipse',is.corr=FALSE)

corrplot(var$contrib,method= 'square', is.corr=FALSE)

corrplot(var$coord,method= 'color', is.corr=FALSE)

corrplot(var$cor,method= 'circle', is.corr=FALSE)
