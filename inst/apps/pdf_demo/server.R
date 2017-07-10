server = function(input, output, session) {
  
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