server = function(input, output, session) {
  
output$example1.8 <- renderUI({ 
  withMathJax(HTML(includeMarkdown('background.Rmd')))
})

  output$printedcircuitboard <- DT::renderDataTable({ DT::datatable(SMRD::printedcircuitboard,
                                                       options = list(pageLength = 10)) })
  
  output$plotfig9 <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4,4,2,2))
      input$evalfig9
      return(isolate(eval(parse(text=input$fig9plot))))
})
}