server = function(input, output, session) {
  
  output$plots <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4,4,2,2))
      input$evalplots
      return(isolate(eval(parse(text=input$plots))))
})
  output$plottypes = renderPlot({
      par(mar = c(5,4,2,2))
      set.seed(4)
      x<-sort(sample(1:50,size = 10))
      y<-sort(sample(1:50,size = 10))
      plot(x, y, 
           type = switch(input$types,
                         "'p' (Points)" = {"p"}, 
                         "'l' (Line)" = {"l"},
                         "'b' (Both)" = {"b"},
                         "'c' (Cutout)" = {"c"},
                         "'o' (Overplotted)" = {"o"},
                         "'h' (Histogram)" = {"h"},
                         "'s' (Step1)" = {"s"},
                         "'S' (Step2)" = {"S"}, 
                         "'n' (No Plot)" = {"n"} ))
})
  output$cexplot <- renderPlot({
      plot(x = 1:15,y = 1:15,
           xlab = "Side 1", 
           ylab = "Side 2", 
           main = "Title",
           cex = input$cex, cex.axis = input$cex.axis, 
           cex.lab = input$cex.lab, cex.main = input$cex.main)
      box(lwd = 2)
})
  output$objectplot <- renderPlot({
      plot(x = 1:15,y = 1:15,
           xlab = "Side 1", 
           ylab = "Side 2", 
           cex = 3,
           pch = input$pch, 
           col = input$col, 
           lty = input$lty, 
           lwd = input$lwd, 
           type = "b")
      box(lwd = 2)
})
output$axis <- renderPlot({
    par(oma = c(0,0,0,0), mar = c(5,4,2,2))
    plot(x = 1:15,y = 1:15,
         xlab = "Side 1",
         ylab = "Side 2",
         main = "Title",
         ann = input$ann, 
         axes = input$axes, 
         xaxt = switch(input$xaxt, 
                       "Show 's'" = "s", 
                       "No Show 'n'" = "n"), 
         yaxt = switch(input$yaxt, 
                       "Show 's'" = "s", 
                       "No Show 'n'" = "n"))
})  
}