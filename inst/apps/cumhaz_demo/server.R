server = function(input, output, session) {

output$HAZdemo <- renderUI({ insertRmd('backgroundchaz.Rmd') })

output$HAZr <- renderUI({ insertRmd('rfuncschaz.Rmd') })

observeEvent(input$evalHAZ, { 
              
output$plotHAZ <- renderPlot({

  return(isolate(eval(parse(text=input$HAZplot))))
})
})
}