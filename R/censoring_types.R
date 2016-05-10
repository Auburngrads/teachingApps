censoring_types <-
function(...) {
  
  loadNamespace('shiny')

shinyApp(options = list(height = '250px', width = '100%'), 
  ui = fluidPage(theme = shinythemes::shinytheme('flatly'), includeCSS('css/my-shiny.css'),         sidebarLayout(
    sidebarPanel(width = 3,
  selectInput("censor", 
              label = h2("Type of Censoring"),
              choices = c("Exact Failures", "Singly Censored", "Inspection Data"),
              selected = "Exact Failures")),
  
  mainPanel(plotOutput("plotcens", height = "200px"), width = 9))),

server = function(input, output, session) {
  
  output$plotcens <- renderPlot({

  par(family="serif",mar = c(0,0,0,0))
  set.seed(2)
  xspots<-sort(runif(5,2,85))
  
if(input$censor=="Exact Failures") {
  
  plot(NA,axes=FALSE,xlab="",ylab="",xlim=range(0,105),ylim=range(0,50))
  segments(0,30,0,20,lwd=2)
  arrows(0,25,100,25,lwd=2)
  text(c(0,104),c(12,25), c(0,expression(infinity)), cex=c(2,3))
  text(xspots,rep(25.5,5),rep("X",5), cex=2, col=1)
  
  text(xspots,rep(12,5), c(expression(t[1]),expression(t[2]),
                           expression(t[3]),expression(t[4]),
                           expression(t[5])),  cex=1.5, col=1)
  text(xspots,rep(38,5), c(expression(F(t[1])),expression(F(t[2])),
                           expression(F(t[3])),expression(F(t[4])),
                           expression(F(t[5]))), cex=1.5, col=1)
}
  
if(input$censor=="Singly Censored") {
    
  plot(NA,axes=FALSE,xlab="",ylab="",xlim=range(0,105),ylim=range(0,50))
  segments(c(0,80),c(30,30),c(0,80),c(20,20),lwd=c(rep(2,3)))
  arrows(0,25,100,25,lwd=2)
  text(c(0,104),c(12,25), c(0,expression(infinity)), cex=c(2,3))
  text(xspots,rep(25.5,5),c(rep("X",4),"?"), cex=2, col=c(1,1,1,1,2))
  text(c(xspots[1:4],80),rep(12,5),
       c(expression(t[1]),expression(t[2]),
         expression(t[3]),expression(t[4]),expression(t[c])), cex=2, col=c(1,1,1,1,2))
  text(c(xspots[1:4],80),rep(38,5),
       c(expression(F(t[1])),expression(F(t[2])),
         expression(F(t[3])),expression(F(t[4])),expression(F(t[c]))), 
       cex=1.5, col=c(1,1,1,1,2))
}
  
if(input$censor=="Inspection Data") {
  
  plot(NA,axes=FALSE,xlab="",ylab="",xlim=range(0,105),ylim=range(0,50))
  segments(seq(0,80,20),rep(30,5),seq(0,80,20),rep(20,5),lwd=rep(2,5))
  arrows(0,25,100,25,lwd=2)
  text(c(0,104),c(12,25), c(0,expression(infinity)), cex=c(2,3))
  text(xspots,rep(25.5,5),"?", cex=2, col=c(rep("blue",4),2))
  text(c(20,20,60,80,104),c(12,0,12,12,12),
       c(expression(t[1]),expression(t[2]),
         expression(t[3]),expression(t[4]),expression(t[5])), cex=2, col=c(4,4,4,4,2))
  text(c(20,60,80,104),rep(38,4),
       c(expression(pi(t[1])),expression(pi(t[3])),
         expression(pi(t[4])),expression(pi(t[5]))), 
       cex=1.5, col=c(4,4,4,2))
}
})
})
}
