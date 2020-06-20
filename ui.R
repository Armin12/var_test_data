# This application predicts the Species label of a flower given
#the petal and sepal length and width for the flower.

# The model is trained with Random Forest and all four features
# in the Iris dataset are being used. 150 data samples in this 
# dataset are divided into 70% for training and 30% for testing.

# You can choose any number of test data using the sidebar
# which is between 1 to 45 which is included in the test set
# The output plot shows which samples are predicted correctly
# and which are not.
# Using radio buttons, you can select to show different
# information on Y and X axes (features).
# The App also presents predicted values at the bottom.

# when you run the App, it takes few seconds for the plot to
# appear.

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