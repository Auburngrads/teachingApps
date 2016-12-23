server = function(input, output, session) {
  library(SMRD)
  output$heatexchanger <- DT::renderDataTable({ DT::datatable(heatexchanger,
                                                       options = list(pageLength = 10)) })
output$plotfig6 <- renderPlot({
      par(mar = c(0,0,0,0))
      input$evalfig6
      return(isolate(eval(parse(text=input$fig6plot))))
})
output$plotfig7 <- renderPlot({
      par(mar = c(0,0,0,0))
      input$evalfig7
      return(isolate(eval(parse(text=input$fig7plot))))
})
}