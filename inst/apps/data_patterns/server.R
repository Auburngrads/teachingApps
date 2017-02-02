server = function(input, output, session) {

output$plotpdflike <- renderPlot({
      input$evalpdflike      
      return(isolate(eval(parse(text=input$pdflikeplot))))
})
}