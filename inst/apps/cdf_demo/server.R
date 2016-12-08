server = function(input, output, session) {
  
output$cdfdemo <- renderUI({ insertRmd('backgroundcdf.Rmd') })

output$cdfr <- renderUI({ insertRmd('rfuncscdf.Rmd') })  

output$plotcdf <- renderPlot({
      input$evalcdf
      return(isolate(eval(parse(text=input$cdfplot))))
})
}