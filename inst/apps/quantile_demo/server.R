server = function(input, output, session) {
  
output$quandemo <- renderUI({ 
  withMathJax(HTML(includeMarkdown('backgroundquan.Rmd')))
})

output$quanr <- renderUI({ 
  withMathJax(HTML(includeMarkdown('rfuncsquan.Rmd')))
})

observeEvent(input$evalquant, { 
  
output$plotquant <- renderPlot({
      
      return(isolate(eval(parse(text=input$quantplot))))
})
})

observeEvent(input$evalfig3, { 
  
output$plotfig3 <- renderPlot({
      
      return(isolate(eval(parse(text=input$fig3plot))))
})
})
}