server = function(input, output, session) {
  
output$example7.1 <- renderUI({ 
  withMathJax(HTML(includeMarkdown('background.Rmd')))
})
output$berkson <- DT::renderDataTable({ 
  
L <- c(0,100,300,500,700,1000,2000,4000)
U <- c(100,300,500,700,1000,2000,4000,'Inf')
n.10220 <- c(1609, 2424,1770,1306,1213,1528,354,16)
n.2000 <- c(292,494,332,236,261,308,73,4)
n.200 <- c(41,44,24,32,29,21,9,0)
n.20 <- c(3,7,4,1,3,2,0,0)
table.7.1 <- data.frame(L,U,n.10220,n.2000,n.200,n.20)

colnames(table.7.1) <- c("Lower","Upper","n = 10220","n = 2000","n = 200","n = 20")

DT::datatable(table.7.1, options = list(pageLength = 10))
})
output$plotfig71 <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4,4,2,2))
      input$evalfig71
      return(isolate(eval(parse(text=input$fig71plot))))
})
}