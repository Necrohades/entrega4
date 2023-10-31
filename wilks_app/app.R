#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
source("wilks.R")

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Distribución Lambda de Wilks"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("p",
                        "p:",
                        min = 1,
                        max = 50,
                        value = 30),
            sliderInput("a",
                        "a:",
                        min = 1,
                        max = 50,
                        value = 30),
            sliderInput("b",
                        "b:",
                        min = 1,
                        max = 50,
                        value = 30),
            sliderInput("N",
                        "Tamaño de la muestra:",
                        min = 1,
                        max = 1000,
                        value = 400)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x <- lambda.wilks(input$N, input$p, input$a, input$b)
        data <- data.frame(x)
        
        ggplot(data, aes(x=x)) +
          # geom_density(fill="#69b3a2", color="#e9ecef", alpha=0.8) +
          geom_histogram(fill="#005DB5")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
