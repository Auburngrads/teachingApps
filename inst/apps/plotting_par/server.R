server = function(input, output, session) {

output$marplot <- renderPlot({
      par(mar = c(input$mar1, input$mar2, input$mar3, input$mar4), xpd = TRUE)
      plot(1:10,1:10,
           xlab = "Side 1", 
           ylab = "Side 2", 
           main = "Title",
           xlim = c(1,7), 
           ylim = c(1,7), 
           type = "l")
      text(1,3.5, 
           labels = "mar( ) RESIZES THE PLOT AREA WITHIN THE PLOT WINDOW - THE 'INNER BOX'", 
           cex = 1.5, 
           adj = 0)
      box(lwd = 2)
})
  output$omaplot <- renderPlot({
      par(oma = c(input$oma1, input$oma2, input$oma3, input$oma4), xpd = TRUE)
      plot(1:10,1:10,
           xlab = "Side 1", 
           ylab = "Side 2", 
           main = "Title", 
           xlim = c(1,7), 
           ylim = c(1,7), 
           type = "l")
      text(1,3.5, "oma( ) RESIZES THE ENTIRE PLOT WINDOW - THE 'OUTER BOX'", 
           cex = 1.5, 
           adj = 0)
      box(lwd = 2)
})
  output$curves <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4.5,4,2,2))
      input$curveseval
      return(isolate(eval(parse(text=input$curvescode))))
})
  output$plots <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4.5,4,2,2))
      input$plotseval
      return(isolate(eval(parse(text=input$plotscode))))
})
}