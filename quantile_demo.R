quantile_demo <-
function(...) {
  
  library(shiny)
  
shinyApp(options = list(width = "99%", height = "800px"),
ui = navbarPage(theme = shinythemes::shinytheme("flatly"), includeCSS('css/my-shiny.css'),

tabPanel(h4("Quantile Function Plot"),titlePanel("Change the code and click 'Evaluate' to edit the Quantile plot"),
  sidebarLayout( 
    sidebarPanel(
      shinyAce::aceEditor("quantplot", mode = "r", theme = "github", height = "450px", fontSize = 15,
                      value = "par(family='serif',mar = c(4,6,2,1))

curve(
qweibull(x,shape = 1.7, scale = 1),
xlab = 'Time, t',
ylab = expression(F**-1*(t)[Weibull]),
ylim = c(0,3),
xlim = c(0,1),
lwd = 3,
lty = 1,
col = 2,
cex.lab = 1.5,
cex.axis = 1.5,
las = 1)"),
              actionButton("evalquant", h4("Evaluate"))),
        
        mainPanel(plotOutput("plotquant", height = "600px")))),
                
tabPanel(h4("Figure 2.3"),titlePanel("Change the code and click 'Evaluate' to edit the scatterplot in Figure 2.3"),
  sidebarLayout( 
    sidebarPanel(
      shinyAce::aceEditor("fig3plot", mode = "r", theme = "github", height = "450px",
                      value = "par(mfrow=c(1,2),family='serif', font=2)\n
x<-seq(0,2.4,by=.01)
y<-pweibull(seq(0,2.4,by=.01), shape=1.7, scale=1)
z<-dweibull(seq(0,2.4,by=.01), shape=1.7, scale=1)\n
plot(x, z, type='l',lwd=1.25, xlab='t', ylab='f(t)',\n main = 'Probability Density Function', las = 1)
polygon(c(seq(0,.4,.01),.4),\nc(dweibull(seq(0,.4,.01),shape=1.7,scale=1),0),\ncol='black')
text(1.25,.1,'Shaded Area = 0.2')
box(lwd=1.25)\n\n
plot(x, y, type='l',lwd=1.25,xlab='t', ylab='F(t)',\n main = 'Cumulative Distribution Function', las = 1)
arrows(c(0,qweibull(.2,shape=1.7,scale=1)),c(.2,.2),
       c(qweibull(.2,sh=1.7,sc=1),
qweibull(.2,sh=1.7,sc=1)),c(.2,0),lwd=.5)\n
par(mfrow=c(1,1))\n
mtext(side = 1,\n'Figure 2.3 - Plots showing that the quantile function is the inverse of the cdf',\nline = 4)"),
              actionButton("evalfig3", h4("Evaluate"))),
        
        mainPanel(plotOutput("plotfig3", height = "600px"))))),

server = function(input, output, session) {
  
output$plotquant <- renderPlot({
      input$evalquant
      return(isolate(eval(parse(text=input$quantplot))))
})  
output$plotfig3 <- renderPlot({
      input$evalfig3
      return(isolate(eval(parse(text=input$fig3plot))))
})
})
}
