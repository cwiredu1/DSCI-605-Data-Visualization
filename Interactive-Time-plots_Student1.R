library(shiny)
library(datasets)


ui <- shinyUI(fluidPage(
  titlePanel("Time Series Plot"),
  tabsetPanel(
    tabPanel("Upload File",
             titlePanel("Uploading Files"),
             sidebarLayout(
               sidebarPanel(
                 fileInput('file1', 'Choose CSV File',
                           accept=c('text/csv', 
                                    'text/comma-separated-values,text/plain', 
                                    '.csv')),
                 
                 # added interface for uploading data from
               
                 tags$br(),
                 checkboxInput('header', 'Header', TRUE),
                 radioButtons('sep', 'Separator',
                              c(Comma=',',
                                Semicolon=';',
                                Tab='\t'),
                              ','),
                 radioButtons('quote', 'Quote',
                              c(None='',
                                'Double Quote'='"',
                                'Single Quote'="'"),
                              '"')
                 
               ),
               mainPanel(
                 tableOutput('contents')
               )
             )
    ),
    tabPanel("Plot",
             pageWithSidebar(
               headerPanel('My First Plot'),
               sidebarPanel(
                 
                 # "Empty inputs" - they will be updated after the data is uploaded
                 selectInput('xcol', 'X Variable', ""),
                 selectInput('ycol', 'Y Variable', "", selected = ""),
                 selectInput('zcol', 'City', "", selected = "")
                 
               ),
               mainPanel(
                 plotOutput('MyPlot1')
               )
             )
    )
    
  )
)
)


server <- shinyServer(function(input, output, session) {
  # added "session" because updateSelectInput requires it
  
  
  data <- reactive({ 
    req(input$file1) ## ?req #  require that the input is available
    
    inFile <- input$file1 
    
    # tested with a following dataset: write.csv(mtcars, "mtcars.csv")
    # and                              write.csv(iris, "iris.csv")
    df <- read.csv(inFile$datapath, header = input$header, sep = input$sep,
                   quote = input$quote)
    
    
    # Update inputs (you could create an observer with both updateSel...)
    # You can also constraint your choices. If you wanted select only numeric
    # variables you could set "choices = sapply(df, is.numeric)"
    # It depends on what do you want to do later on.
    
    updateSelectInput(session, inputId = 'xcol', label = 'X Variable',
                      choices = names(df), selected = names(df))
    updateSelectInput(session, inputId = 'ycol', label = 'Y Variable',
                      choices = names(df), selected = names(df)[2])
    updateSelectInput(session, inputId = 'zcol', label = 'City',
                      choices = unique(df$city), selected = df$city[1])
    return(df)
  })
  
  output$contents <- renderTable({
    data()
  })
  
  output$MyPlot1 <- renderPlot({
    par(mfrow=c(2,1))
    data1 <- data()[data()$city %in% input$zcol, c(input$xcol, input$ycol)]
    plot(data1,type="l",lty=1)
    hist(data()[data()$city %in% input$zcol,c(input$ycol)],xlab=c(input$ycol),main="")
    
  })

})

shinyApp(ui, server)