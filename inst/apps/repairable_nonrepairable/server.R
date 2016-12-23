server = function(input, output, session) {
  
output$reptext <- renderUI({ 
  withMathJax(HTML(includeMarkdown('repairable.Rmd')))
})
output$plotrep <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4,4,2,2))
      input$evalrep
      return(isolate(eval(parse(text=input$repplot))))
})
output$noreptext <- renderUI({ 
  withMathJax(HTML(includeMarkdown('nonrepairable.Rmd')))
})
output$plotnorep <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4,4,2,2))
      input$evalnorep
      return(isolate(eval(parse(text=input$norepplot))))
})
}
