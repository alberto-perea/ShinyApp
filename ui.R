library(shiny)

shinyUI(fluidPage(

    titlePanel("Predict MPG from Weight and Cylinders"),

    sidebarLayout(
        sidebarPanel(
            sliderInput("sliderWT","Weight of the car in Tons?",0.5, 3, step = 0.2, value = 1.5),
            selectInput("selectCyl", "Select number of Cylinders",c(4 , 6, 8), selected = 4)
        ),

        mainPanel(
            plotOutput("plot1"),
            h3("Predicted MPG: "),
            textOutput("pred")
        )
    )
))
