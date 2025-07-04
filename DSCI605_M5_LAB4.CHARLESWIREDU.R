getwd()
setwd("C:/Users/owner/Desktop/Data Science")

### install packages required for the plots
##install.packages("ggplot2")
##install.packages("dplyr")
##install.packages("hrbrthemes")
##install.packages("viridis")

##library(ggplot2)
##library(dplyr)
##library(hrbrthemes)
##library(viridis)

######load dataset for bubble graph
###################USArrests##################################
data("USArrests")
df <- USArrests
names(USArrests)

USArrests_data <- 
  tibble(State = state.name,
         Region = state.region) %>%
  bind_cols(USArrests)

names(USArrests_data)

##############basic bubble plot######################
###PLOT1###
USArrests_data %>% 
  ggplot(aes(x=Assault,y=Murder, size=Rape)) +
  geom_point(alpha=0.6)+
  scale_size_continuous(range = c(1, 8))+
  labs(x="Assault", y="Murder", size="Rape")

##adding more features1
USArrests_data %>%
  arrange(desc(UrbanPop)) %>%
  ggplot(aes(x=Murder, y=Assault, size=Rape ,fill=Region)) +
  geom_point(alpha=0.5, shape=21, color="black") +
  scale_size(range = c(.1, 7), name="Urban Population ") +
  scale_fill_viridis(discrete=TRUE, guide=FALSE, option="A") +
  theme(legend.position="bottom")+
  ylab("Murder") +
  xlab("Assault") +
  theme(legend.position = "none")

###features 2 with title added
USArrests_data %>% 
  ggplot(aes(x=Rape,y=Murder, size=UrbanPop, color=Assault)) + 
  geom_point(alpha=0.8)+
  scale_size_continuous(range = c(1, 8))+
  labs(title="Bubble plot on Rape/Murder in Usa", x="Rape", y="Murder", size="UrbanPop", color="Assault")


################ box plot####################
###using USArrest dataset#####
boxplot(Rape~UrbanPop,
        data=USArrests_data,
        main= "Boxplot on Murderand Assault in USA",
        xlab= "UrbanPop",
        ylab= "Rape",
        col= "yellow",
        border= "brown")

#### box plot with ggplot
ggplot(USArrests_data, aes(x=Rape,y=Murder, fill=Region)) + 
  geom_boxplot()+ title("Boxplot on Murder/Rape with Regions ")

############BAR PLOT########################
#########using USArrest dataset##########
### basic bar plot
##plot1
ggplot(USArrests_data, aes(x=Region, y=Murder)) +
  geom_bar(stat="identity")
##plot2
ggplot(USArrests_data, aes(x=Region, y=Assault)) +
  geom_bar(stat="identity")
##plot3
ggplot(USArrests_data,aes(x=UrbanPop,
     y=Murder,col=Rape,fill=Rape))+geom_col()
##plot4
ggplot(USArrests,aes(x=UrbanPop,
                     y=Murder,
                     col=Rape,
                     fill=Assault))+geom_col()+labs(x="Population", y="Murder per 10,000",
                      title= "Murder with Urban Pop as a function: With Rape & Assault")

