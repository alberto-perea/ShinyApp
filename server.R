library(shiny)

shinyServer(function(input, output) {
    data("mtcars")
    mtcars$wt <- mtcars$wt*0.5
    
    cyl4 <- subset(mtcars, cyl == 4, select = c("mpg", "wt"))
    cyl6 <- subset(mtcars, cyl == 6, select = c("mpg", "wt"))
    cyl8 <- subset(mtcars, cyl == 8, select = c("mpg", "wt"))
    
    
    
    model1 <- lm(mpg ~ wt, data = cyl4)
    model2 <- lm(mpg ~ wt, data = cyl6)
    model3 <- lm(mpg ~ wt, data = cyl8)
    
    modelpred <- reactive({
        wtInput <- input$sliderWT
        
        if(input$selectCyl == 4 ){
            x <- predict(model1, newdata = data.frame(wt = wtInput))    
        }
        
        if(input$selectCyl == 6 ){
            x <- predict(model2, newdata = data.frame(wt = wtInput))    
        }
        
        if(input$selectCyl == 8 ){
            x <- predict(model3, newdata = data.frame(wt = wtInput))    
        }
        
        x
    })
    

    output$plot1<-renderPlot({
        wtInput <- input$sliderWT
        
        plot(mtcars$wt, mtcars$mpg, xlab = "Weight in Tons", 
             ylab = "Miles per Gallon", bty = "n", pch = 16,
             xlim = c(0.5, 3), ylim = c(0, 35))
        
        if(input$selectCyl == 4){
            abline(model1, col = "red", lwd = 2)
            points(wtInput, modelpred(), col = "red", pch = 16, cex = 2)
        }
        
        
       if(input$selectCyl == 6){
            abline(model2, col = "blue", lwd = 2)
            points(wtInput, modelpred(), col = "blue", pch = 16, cex = 2)
        }
        
        if(input$selectCyl == 8){
            abline(model3, col = "yellow", lwd = 2)
            points(wtInput, modelpred(), col = "yellow", pch = 16, cex = 2)
        }
        
        legend(x = "topright", legend = c("Cyl 4", "Cyl 6", "Cyl 8"), pch = 16,
               col = c("red", "blue", "yellow"), bty = "n", cex = 1)
       
    })
    
    output$pred <- renderText({
        modelpred()
        
    })

})
