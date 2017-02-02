server = function(input, output, session) {
 
output$plotcens <- renderPlot({

  par(family="serif",mar = c(0,0,0,0))
  set.seed(2)
  xspots<-sort(runif(5,2,85))
  
if(input$censor=="Exact Failures") {
  
  plot(NA,
       axes = FALSE,
       xlab = "",
       ylab = "",
       xlim = range(0,105),
       ylim = range(0,50))
  segments(x0 = 0,
           y0 = 30,
           x1 = 0,
           y1 = 20,
           lwd = 2)
  arrows(x0 = 0,
         y0 = 25,
         x1 = 100,
         y1 = 25,
         lwd = 2)
  text(x = c(0,104, rep(xspots,3)),
       y = c(12,25,rep(25.5,5),rep(12,5),rep(38,5)), 
       labels = c(0,
                  expression(infinity),
                  rep("X",5),
                  expression(t[1]),
                  expression(t[2]),
                  expression(t[3]),
                  expression(t[4]),
                  expression(t[5]),
                  expression(F(t[1])),
                  expression(F(t[2])),
                  expression(F(t[3])),
                  expression(F(t[4])),
                  expression(F(t[5]))),
       cex = c(2,3,
               rep(2,5), 
               rep(1.5,10)))
}
  
if(input$censor=="Singly Censored") {
    
  plot(NA,
       axes = FALSE,
       xlab = "",
       ylab = "",
       xlim = range(0,105),
       ylim = range(0,50))
  segments(x0 = c(0,80),
           y0 = c(30,30),
           x1 = c(0,80),
           y1 = c(20,20),
           lwd = c(rep(2,3)))
  arrows(x0 = 0,
         y0 = 25,
         x1 = 100,
         y1 = 25,
         lwd = 2)
  text(x = c(0,104,xspots, rep(c(xspots[1:4],80),2)),
       y = c(12,25, rep(25.5,5), rep(12,5),rep(38,5)), 
       labels = c(0,
                  expression(infinity),
                  rep("X",4),"?",
                  expression(t[1]),
                  expression(t[2]),
                  expression(t[3]),
                  expression(t[4]),
                  expression(t[c]),
                  expression(F(t[1])),
                  expression(F(t[2])),
                  expression(F(t[3])),
                  expression(F(t[4])),
                  expression(F(t[c]))), 
       cex = c(2,3, rep(c(2,1.5), times = c(10,5))),
       col = c(1,1,rep(c(1,1,1,1,2),3)))
}
  
if(input$censor=="Inspection Data") {
  
  plot(NA,
       axes = FALSE,
       xlab = "",
       ylab = "",
       xlim = range(0,105),
       ylim = range(0,50))
  segments(x0 = seq(0,80,20),
           y0 = rep(30,5),
           x1 = seq(0,80,20),
           y1 = rep(20,5),
           lwd = rep(2,5))
  arrows(x0 = 0,
         y0 = 25,
         x1 = 100,
         y1 = 25,
         lwd = 2)
  text(x = c(0,104,xspots,20,20,60,80,104,20,60,80,104),
       y = c(12,25,rep(25.5,5),12,0,12,12,12,rep(38,4)), 
       labels = c(0,
                  expression(infinity),
                  rep("?",5),
                  expression(t[1]),
                  expression(t[2]),
                  expression(t[3]),
                  expression(t[4]),
                  expression(t[5]),
                  expression(pi(t[1])),
                  expression(pi(t[3])),
                  expression(pi(t[4])),
                  expression(pi(t[5]))), 
       cex = c(2,3,rep(c(2,1.5), times = c(10,4))),
       col = c(1,1,rep("blue",4),2,4,4,4,4,2,4,4,4,2))
}
})
}