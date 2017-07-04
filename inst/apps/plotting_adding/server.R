server = function(input, output, session) {

  output$text <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4.5,4,2,2))
      input$texteval
      return(isolate(eval(parse(text=input$textcode))))
})
  output$eqn <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4.5,4,2,2))
      input$eqneval
      return(isolate(eval(parse(text=input$eqncode))))
})
  output$point <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4.5,4,2,2))
      input$pteval
      return(isolate(eval(parse(text=input$ptcode))))
})

output$abline0 <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4.5,4,2,2))
      input$lineeval
      return(isolate(eval(parse(text=input$linecode))))
})
output$abline1 <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4.5,4,2,2))
      input$abeval1
      return(isolate(eval(parse(text=input$abcode1))))
})
output$abline2 <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4.5,4,2,2))
      input$abeval2
      return(isolate(eval(parse(text=input$abcode2))))
})
  
output$lineace <- renderUI({ switch(input$lines,
                           
    'lines1' = {
    
    shinyAce::aceEditor(fontSize = 16, 
                        wordWrap = T,
                        outputId = "linecode", 
                        mode = "r", 
                        theme = "github", 
                        height = "475px", 
                        value = 
"set.seed(NULL)

x<-sort(sample(1:50,size = 10))
y<-sort(sample(1:50,size = 10))

plot(x, y)

points(c(10,5), c(14,27),
       cex = 8,
       pch = 16,
       col = 'gold')

points(c(10,5), c(14,27),
       cex = 2,
       pch = '$',
       col = 'white')

lines(c(10,5), c(14,27),
      lwd = 2,
      col = 'green')")},
      
  'lines2' = { 
    
    shinyAce::aceEditor(fontSize = 16, 
                        wordWrap = T,
                        outputId = "abcode1", 
                        mode = "r", 
                        theme = "github", 
                        height = "475px", 
                        value = 
"set.seed(NULL)

x<-sort(sample(1:50,size = 10))
y<-sort(sample(1:50,size = 10))

plot(x, y)

points(c(10,5), c(14,27),
       cex = 8,
       pch = 16,
       col = 'gold')

points(c(10,5), c(14,27),
       cex = 2,
       pch = '$',
       col = 'white')

abline(a = 10, b = 3,
       lwd = 2, 
       col = 'green')")},
    
 'lines3' = {
    
    shinyAce::aceEditor(fontSize = 16, 
                        wordWrap = T,
                        outputId = "abcode2", 
                        mode = "r", 
                        theme = "github", 
                        height = "475px", 
                        value = 
"set.seed(NULL)

x<-sort(sample(1:50,size = 10))
y<-sort(sample(1:50,size = 10))

plot(x, y)

points(c(10,5), c(14,27),
       cex = 8, 
       pch = 16, 
       col = 'gold')

points(c(10,5), c(14,27),
       cex = 2, 
       pch = '$', 
       col = 'white')

abline(h = 10, v = 30,
       lwd = 2, 
       col = 'green')")})
})
output$lineact <- renderUI({ switch(input$lines,
                           
  'lines1' = { actionButton("lineeval", "Evaluate")},

  'lines2' = { actionButton("abeval1", "Evaluate")},
  
  'lines3' = { actionButton("abeval2", "Evaluate")})
})

  output$grid <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4.5,4,2,2))
      input$grideval
      return(isolate(eval(parse(text=input$gridcode))))
})
  output$legend <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4.5,4,2,2))
      input$legeval
      return(isolate(eval(parse(text=input$legcode))))
})
}