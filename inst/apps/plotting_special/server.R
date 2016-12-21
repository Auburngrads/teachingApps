server = function(input, output, session) {

  output$barplot <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4.5,4,2,2))
      input$bareval
      return(isolate(eval(parse(text=input$barcode))))
})
  output$piechart <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4.5,4,2,2))
      input$pie
      return(isolate(eval(parse(text=input$piecode))))
})
  output$boxplot <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4.5,4,2,2))
      input$boxeval
      return(isolate(eval(parse(text=input$boxcode))))
})
output$trellis <- renderPlot({
    plot(datasets::mtcars[,c(input$mtcars)], col = rainbow(length(input$mtcars)), 
         pch = 16, cex = 1+length(input$mtcars)*.1)
})
}