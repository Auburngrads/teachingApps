server = function(input, output, session) {
  
output$survdemo <- renderUI({ 
  withMathJax(HTML(includeMarkdown('backgroundsurv.Rmd')))
})

output$survr <- renderUI({ 
  withMathJax(HTML(includeMarkdown('rfuncssurv.Rmd')))
}) 

observeEvent(input$evalrel, { 

output$plotrel <- renderPlot({
      
      return(isolate(eval(parse(text=input$relplot))))
})
})
}