server = function(input, output, session) {
  
output$pdfdemo <- renderUI({ 
  withMathJax(HTML(includeMarkdown('backgroundpdf.Rmd')))
})

output$pdfr <- renderUI({ 
  withMathJax(HTML(includeMarkdown('rfuncspdf.Rmd')))
})

observeEvent(input$evalpdf, { 

output$plotpdf <- renderPlot({
      
      return(isolate(eval(parse(text=input$pdfplot))))
})
})
}