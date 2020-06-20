
library(shiny)
shinyUI(fluidPage(
    titlePanel("Predict Species from Petal and Sepal Information"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("sliderTestPoints", "What is the number of test examples to use?", 1, 45, value = 20),
            radioButtons("X.Y", 
                         "Show Results of Y vs X", 
                         choices = c("Petal.Width.Petal.Length", 
                                     "Sepal.Width.Sepal.Length",
                                     "Petal.Width.Sepal.Length",
                                     "Sepal.Width.Petal.Length"),
                         selected=c("Petal.Width.Petal.Length")),
            submitButton("Submit") # after pressing button it changes
        ),
        mainPanel(
            plotOutput("plot"),
            h3("Predicted Species from Model:"),
            textOutput("pred")
        )
    )
))
