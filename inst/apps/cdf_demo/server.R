server = function(input, output, session) {
  
output$cdfdemo <- renderUI({ add_rmd('backgroundcdf.Rmd') })

output$cdfr <- renderUI({ add_rmd('rfuncscdf.Rmd') })  

output$plotcdf <- renderPlot({
      input$evalcdf
      return(isolate(eval(parse(text=input$cdfplot))))
})
}