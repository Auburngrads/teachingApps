server = function(input, output, session) {

output$mlexp2 <- renderPrint({
      par(family = 'serif', mar = c(4,4,1,2))
      input$mlexpnums
      return(isolate(eval(parse(text=input$mlexpnum))))
})
}