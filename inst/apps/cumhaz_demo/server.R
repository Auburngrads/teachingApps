server = function(input, output, session) {

output$HAZdemo <- renderUI({ add_rmd('backgroundchaz.Rmd') })

output$HAZr <- renderUI({ add_rmd('rfuncschaz.Rmd') })

observeEvent(input$evalHAZ, { 
              
output$plotHAZ <- renderPlot({

  return(isolate(eval(parse(text=input$HAZplot))))
})
})
}