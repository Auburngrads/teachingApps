server = function(input, output, session) {

output$HAZdemo <- renderUI({ add_rmd('backgroundchaz.Rmd') })

output$HAZr <- renderUI({ add_rmd('rfuncschaz.Rmd') })

output$plotHAZ <- renderPlot({
  input$evalHAZ
  return(isolate(eval(parse(text=input$HAZplot))))

})
}