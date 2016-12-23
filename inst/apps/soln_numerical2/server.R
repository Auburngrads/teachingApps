server = function(input, output, session) {

output$mlsolns <- renderPrint({
      par(family = 'serif', mar = c(4,4,1,2))
      input$mlsolnum
      return(isolate(eval(parse(text=input$solnum))))
})
}