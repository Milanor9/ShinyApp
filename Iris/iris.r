#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)  # for the diamonds dataset

ui <- fluidPage(
    titlePanel("Iris Dataset"),
    
    # Sidebar layout with input and output definitions ----
    sidebarLayout(
        
        # Sidebar panel for inputs ----
        sidebarPanel(
            
            # Input: Slider for the number of bins ----
            varSelectInput("variable", "characteristic:", iris)
            
        ),
        mainPanel(
            
            # Output: Histogram ----
            plotOutput(outputId = "data")
            
        ),
    )
    
)

server <- function(input, output) {
    output$data <- renderPlot({
        ggplot(iris, aes(!!input$variable)) + geom_histogram()
    })
    
}

shinyApp(ui, server)