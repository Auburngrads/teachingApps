server = function(input, output, session) {

  respCol <- reactive({ which(colnames(mtcars)%in%input$response) })
  
output$factors <- renderUI({ 
    
    selectInput('factor2',
                'Choose Factors',
                choices = colnames(mtcars)[-respCol()],
                multiple = T)
})
  
output$output <- renderPlot({
        
  par(oma = c(0,0,0,0), mar = c(5,4,2,2))
  data = mtcars
  response <- data[,respCol()]
  
  `if`(is.null(input$factor2),
       model.mat <- rep(1,length(response)),
       model.mat <- as.matrix(data[input$factor2]))

  lm.model <- lm(response ~ model.mat)

  lm.coeff  <- lm.model$coeff
  lm.modmat <- model.matrix(lm.model)
  responses <- lm.modmat%*%lm.coeff
  range <- mean(responses) + c(-3,3) * sd(responses)
  MSE <- sum(lm.model$residuals^2)/(length(lm.model$fitted.values)-2)
  
  models <- lapply(X = responses,
                   FUN = function(y) dnorm(seq(range[1],range[2], length.out = 100),
                                           mean = y, 
                                           sd = sqrt(MSE)))
  
  plot(x = seq(range[1],range[2], length.out = 100),
       y = models[[1]],
       type = 'l')
  lapply(X = 2:length(models),
         FUN = function(x)lines(x = seq(range[1],range[2], length.out = 100),
                                y = models[[x]]))

})  
}