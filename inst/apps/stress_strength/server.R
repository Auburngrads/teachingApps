server <- function(input, output, session) {
 
  output$first <- renderPlot({
    
  jkf.par(mar = c(2,4,2,2))
    
  plot(x = seq(0,30,.1),
       y = dnorm(seq(0,30,.1),input$mean,2),
       xlim = range(0,22),
       ylim = range(0,.2),
       ylab = "", 
       xlab = "Stress",
       type = "l",
       lwd = 2,
       col = "blue")
  segments(x0 = 17,
           y0 = 0,
           x1 = 17,
           y1 = .3,
           col = "red",
           lwd = 4)
  polygon(x = c(17,seq(17,22,.1),22),
          y = c(0,dnorm(seq(17,22,.1),input$mean,2),0),
          col = rgb(1,0,0,.25),
          border = NA)
  text(x = 18.5,
       y = .19,
       labels = "Stress Limit",
       font = 2,
       cex = 1.5)
})
}