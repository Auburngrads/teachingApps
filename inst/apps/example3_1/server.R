server = function(input, output, session) {
  
output$example3.1 <- renderUI({ 
  withMathJax(HTML(includeMarkdown('background.Rmd')))
})
  
output$heatexchanger1 <- DT::renderDataTable({ 
  DT::datatable(subset(heatexchanger, plant == 'Plant1'),
                options = list(pageLength = 10)) 
})
  
output$plotfig31 <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4,4,2,2))
      input$evalfig31
      return(isolate(eval(parse(text=input$fig31plot))))
})
output$fig31text <- renderUI({
  withMathJax(HTML(includeMarkdown('fig31.Rmd')))
})
output$plotfig32 <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4,4,2,2))
      input$evalfig32
      return(isolate(eval(parse(text=input$fig32plot))))
})
output$fig32text <- renderUI({
  withMathJax(HTML(includeMarkdown('fig32.Rmd')))
})
}