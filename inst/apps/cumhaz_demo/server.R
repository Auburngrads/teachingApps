server = function(input, output, session) {

output$HAZdemo <- renderUI({ nestRmd('backgroundchaz.Rmd') })

output$HAZr <- renderUI({ nestRmd('rfuncschaz.Rmd') })

observeEvent(input$evalHAZ, { 
              
output$plotHAZ <- renderPlot({

  return(isolate(eval(parse(text=input$HAZplot))))
})
})
}