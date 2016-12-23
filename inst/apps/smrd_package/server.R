server = function(input, output, session) {
  
output$smrd.back <- renderUI({ 
  withMathJax(HTML(includeMarkdown('background.Rmd')))
})

output$smrd.feat <- renderUI({ 
  withMathJax(HTML(includeMarkdown('features.Rmd')))
})

output$smrd.data <- DT::renderDataTable({ 
  DT::datatable(data(package = 'SMRD')$results[,3:4],
                options = list(pageLength = 10)) 
})
output$smrd.vign <- renderUI({ 
  withMathJax(HTML(includeMarkdown('vignettes.Rmd')))
})

}
