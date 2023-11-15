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
                        max = 10,
                        value = 4),
            sliderInput("a",
                        "a:",
                        min = 1,
                        max = 20,
                        value = 10),
            sliderInput("b",
                        "b:",
                        min = 1,
                        max = 20,
                        value = 10),
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
        betas <- lambda.wilks.betas(input$N, input$p, input$a, input$b)
        wishart <- lambda.wilks.wishart(input$N, input$p, input$a, input$b)
        data <- data.frame(values=c(betas,wishart),type=rep(c("Betas","Wishart"),each=input$N))
        
        ggplot(data,aes(x=values, fill=type)) + 
          geom_histogram(alpha = 0.8, position="identity") +
          labs(x="Valores", y="Frecuencia absoluta", fill="Tipo") +
          scale_fill_manual(values=c("blue", "yellow"))
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
