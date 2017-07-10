server = function(input, output, session) {
  
output$survdemo <- renderUI({ add_rmd('backgroundsurv.Rmd') })

output$survr <- renderUI({ add_rmd('rfuncssurv.Rmd') }) 

output$plotrel <- renderPlot({
  input$evalrel
  return(isolate(eval(parse(text=input$relplot))))
})
}