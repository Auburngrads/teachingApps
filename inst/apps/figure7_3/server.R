server = function(input, output, session) {
  
  output$berksonmle <- renderPlot({
    
par(family="serif",font=2)

berkson <- switch(input$n7.3, 
                  "20" = {SMRD::berkson20},
                  "200" = {SMRD::berkson200},
                  "2000" = {SMRD::berkson2000},
                  "10220" = {SMRD::berkson10220})

berkson.ld <- frame.to.ld(berkson,
                          response.column = c(1,2),
                          censor.column = 3,
                          case.weight.column = 4)

mleprobplot(berkson.ld, distribution = "Exponential")  
})
}