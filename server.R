
library(ggplot2)
library(caret)
library(randomForest)
library(e1071)
library(shiny)
data(iris)
inTrain <- createDataPartition(y=iris$Species,
                               p=0.7, list=FALSE)
training <- iris[inTrain,]
testing <- iris[-inTrain,]

modFit <- train(Species~ ., data=training, 
                method="rf", prox=TRUE)

shinyServer(function(input, output) {
    
    modelpred <- reactive({
        TestPointsInput <- input$sliderTestPoints
        test_data <- testing[1:TestPointsInput, ]
        predict(modFit, newdata = test_data)
    })
    
    output$plot <- renderPlot({
        TestPointsInput <- input$sliderTestPoints
        test_data <- testing[1:TestPointsInput, ]
        test_data$predRight <- modelpred()==test_data$Species
        if(input$X.Y==c("Petal.Width.Petal.Length")){
            ggplot(test_data, aes(x=Petal.Width, y=Petal.Length, color=predRight)) + geom_point() + scale_color_manual(breaks = c("TRUE", "FALSE"),
                                                                                                                       values=c("blue", "red"))
        } else if(input$X.Y==c("Sepal.Width.Sepal.Length")){
            ggplot(test_data, aes(x=Sepal.Width, y=Sepal.Length, color=predRight)) + geom_point() + scale_color_manual(breaks = c("TRUE", "FALSE"),
                                                                                                                       values=c("blue", "red"))
        } else if(input$X.Y==c("Petal.Width.Sepal.Length")){
            ggplot(test_data, aes(x=Petal.Width, y=Sepal.Length, color=predRight)) + geom_point() + scale_color_manual(breaks = c("TRUE", "FALSE"),
                                                                                                                       values=c("blue", "red"))
        } else {
            ggplot(test_data, aes(x=Sepal.Width, y=Petal.Length, color=predRight)) + geom_point() + scale_color_manual(breaks = c("TRUE", "FALSE"),
                                                                                                                       values=c("blue", "red"))
        }
        
    })
    
    output$pred <- renderText({
        modelpred()
    })
    
})