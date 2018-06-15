server = function(input, output, session) {

output$overview <- renderUI({ 
  withMathJax(HTML(includeMarkdown('overview.Rmd')))
})

output$functable <- renderUI({ 
  withMathJax(HTML(includeMarkdown('functable.Rmd')))
}) 
    
output$cdfdemo <- renderUI({ 
  withMathJax(HTML(includeMarkdown('backgroundcdf.Rmd')))
})

output$cdfr <- renderUI({ 
  withMathJax(HTML(includeMarkdown('rfuncscdf.Rmd')))
})  

output$plotcdf <- renderPlot({
    input$evalcdf      
    return(isolate(eval(parse(text=input$cdfplot))))
})
output$pdfdemo <- renderUI({ 
  withMathJax(HTML(includeMarkdown('backgroundpdf.Rmd')))
})

output$pdfr <- renderUI({ 
  withMathJax(HTML(includeMarkdown('rfuncspdf.Rmd')))
})  

output$plotpdf <- renderPlot({
  input$evalpdf
  return(isolate(eval(parse(text=input$pdfplot))))
})
}