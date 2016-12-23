server = function(input, output, session) {
  
output$hazdemo <- renderUI({ 
  withMathJax(HTML(includeMarkdown('backgroundhaz.Rmd')))
})

output$hazr <- renderUI({ 
  withMathJax(HTML(includeMarkdown('rfuncshaz.Rmd')))
})

observeEvent(input$evalhaz, { 
output$plothaz <- renderPlot({
      
      return(isolate(eval(parse(text=input$hazplot))))
})
})

observeEvent(input$evalfigbt, { 
output$plotfigbt <- renderPlot({
      
      return(isolate(eval(parse(text=input$figbtplot))))
})
})
}