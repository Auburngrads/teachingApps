server = function(input, output, session) {
  
output$example1.1 <- renderUI({ nestRmd('background.Rmd') })
  
output$lzbearing <- DT::renderDataTable({ DT::datatable(SMRD::lzbearing,
                                                       options = list(pageLength = 10)) })
  
output$plotfig1 <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4,4,2,2))
      input$evalfig1
      return(isolate(eval(parse(text=input$fig1plot))))
})
output$plotfig2 <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4,4,2,2))
      input$evalfig2
      return(isolate(eval(parse(text=input$fig2plot))))
})
}