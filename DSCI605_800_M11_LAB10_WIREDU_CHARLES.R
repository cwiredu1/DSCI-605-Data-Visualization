install.packages("shiny")
install.packages("plotly")
library(shiny)
library(plotly)

stock <- read.csv('https://raw.githubusercontent.com/plotly/datasets/master/finance-charts-apple.csv')

names(stock)

head(stock)

######################INTIAL  PLOT####################
ui <- fluidPage(
  selectizeInput(
    inputId = "directions", 
    label = "Select a direction", 
    choices = unique(stock$direction), 
    selected = "Increasing",
    multiple = TRUE
  ),
  plotlyOutput(outputId = "p")
)

server <- function(input, output, ...) {
  output$p <- renderPlotly({
    plot_ly(stock, x = ~Date, y = ~AAPL.High) %>%
      filter(direction %in% input$directions) %>%
      group_by(direction) %>%
      add_lines()
  })
}

shinyApp(ui, server)

##################two plots##########################

ui <- fluidPage(
  selectizeInput(
    inputId = "idc", 
    label = "Select a direction of interest", 
    choices = unique(stock$direction), 
    selected = "Decreasing",
    multiple = FALSE
  ),
  plotOutput(outputId = "myplot")
)

server <- function(input, output, ...) {
  selectedData <- reactive({
    stock%>% filter(direction %in% input$idc)
  }) 
  output$myplot <- renderPlot({  
    par(mfrow=c(2,1))
    hist(selectedData()$AAPL.High)
    plot(selectedData()$Date,selectedData()$AAPL.High,type = "l", lty = 1)
  })
}
  
  shinyApp(ui, server)
  
  