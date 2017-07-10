server = function(input, output, session) {
  
output$quandemo <- renderUI({ add_rmd('backgroundquan.Rmd') })

output$quanr <- renderUI({ add_rmd('rfuncsquan.Rmd') })

output$plotquant <- renderPlot({
  input$evalquant
  return(isolate(eval(parse(text=input$quantplot))))
})

output$plotfig3 <- renderPlot({
  input$evalfig3 
  return(isolate(eval(parse(text=input$fig3plot))))
})
}