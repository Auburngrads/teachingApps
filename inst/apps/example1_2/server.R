server = function(input, output, session) {
  
output$example1.2 <- renderUI({ 
  withMathJax(HTML(includeMarkdown('background.Rmd')))
})

  output$lfp1370 <- DT::renderDataTable({ DT::datatable(SMRD::lfp1370,
                                                       options = list(pageLength = 10)) })
  
  output$plotfig3 <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4,4,2,2))
      input$evalfig3
      return(isolate(eval(parse(text=input$fig3plot))))
})
}