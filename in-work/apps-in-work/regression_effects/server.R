server <- function(input, output, session) {
  
  output$regress <- renderPlot({
    
    coefs <- coef(model)[1:3]
    terms <- as.numeric(c(1, input$input1, input$input2))
    mean  <- sum(terms * coefs)
    sd    <- sigma(model)
    
    curve(dnorm(x, mean = mean, sd = sigma(model)), 
          xlim = c(5,30),
          col = 2,
          lwd = 2.5,
          las = 1,
          font = 2,
          ylab = 'f(mpg)',
          xlab = 'mpg',
          cex.axis = 1.5,
          cex.lab = 1.5)
    
  })
  
}
