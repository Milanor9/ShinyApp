#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(rsconnect)

ui <- fluidPage(

    titlePanel("My Shiny App"),
    sidebarLayout(
        sidebarPanel(
            
            # select input with the list of datasets
            selectInput(inputId = "data1", label = "Select the Dataset", choices = c("iris","mtcars","trees")),
            br(),
            helpText("Choose here the characteristics you want to compare"),
            br(),
            uiOutput("vx"), # vx is coming from renderUI in server.r
            br(),
            br(),
            uiOutput("vy") # vy is coming from renderUI in server.r
            
        ),
        mainPanel(
            plotOutput("p")
        )
        
    )
)

server <- function(input, output) {

    var <- reactive({
        switch(input$data1,
               "iris" = names(iris),
               "mtcars" = names(mtcars),
               "trees" = names(trees)
        )
    })
    
    # vx and vy are the output variable from renderUI containing the list of variable names in a selectInput
    # renderUI is used in server side and is used along with uiOutput in the ui.r
    # uiOuput is used in ui.R to display the selectInput dynamically using the output variable vx & vy
    # using vx and vy in the ui.R we will dynamically create the drop down with the column names based on the dataset selected by the user
    
    output$vx <- renderUI({
        selectInput("variablex", "Select the X variable", choices = var())
    })
    
    output$vy <- renderUI({
        selectInput("variabley", "Select the Y variable", choices = var())
    })
    
    # renderPlot is used to plot the ggplot and the plot output will be stored in the output variable p which could be used in ui.r to display the plot
    output$p <- renderPlot({
                attach(get(input$data1))
                plot(x= get(input$variablex), y= get(input$variabley), xlab=input$variablex, ylab=input$variabley)
        
    })
}
# Run the application 
shinyApp(ui = ui, server = server)

