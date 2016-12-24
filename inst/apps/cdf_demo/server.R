server = function(input, output, session) {
  
output$cdfdemo <- renderUI({ nestRmd('backgroundcdf.Rmd') })

output$cdfr <- renderUI({ nestRmd('rfuncscdf.Rmd') })  

output$plotcdf <- renderPlot({
      input$evalcdf
      return(isolate(eval(parse(text=input$cdfplot))))
})
}