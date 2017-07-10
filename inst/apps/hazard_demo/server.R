server = function(input, output, session) {
  
output$hazdemo <- renderUI({ add_rmd('backgroundhaz.Rmd') })

output$hazr <- renderUI({ add_rmd('rfuncshaz.Rmd') })

output$plothaz <- renderPlot({
      input$evalhaz
      return(isolate(eval(parse(text=input$hazplot))))
})

output$plotfigbt <- renderPlot({
      input$evalfigbt
      return(isolate(eval(parse(text=input$figbtplot))))
})
}