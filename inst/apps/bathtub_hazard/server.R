server = function(input, output, session) {

 output$bathtub <- renderPlot({ 
  
  x <- seq(min(input$xrange),max(input$xrange), length.out = 150)   
      
  cdf1 <- pweibull(q = x, shape = input$shape1, scale = input$scale1)
  cdf2 <- pweibull(q = x, shape = input$shape2, scale = input$scale2)
  pdf1 <- dweibull(x = x, shape = input$shape1, scale = input$scale1)
  pdf2 <- dweibull(x = x, shape = input$shape2, scale = input$scale2)
  
  system_cdf <- input$xi * (cdf1 + cdf2 - cdf1 * cdf2) + (1 - input$xi) * cdf2
  system_pdf <- input$xi * (pdf1 * pdf2) + (1 - input$xi) * pdf2
  system_haz <- system_pdf / (1 - system_cdf)
  
  dat <- data.frame(x,cdf1,cdf2,pdf1,pdf2,
                    system_cdf,
                    system_pdf,
                    system_haz)
  
ggh = ggplot(dat, aes(x, system_haz))
  
ggh + geom_line( ) + theme_light(base_size = 18)

})
}
