library(teachingApps)

ui = fluidPage(theme = teachingApps::add_theme(getShinyOption("theme")), 
               teachingApps::add_style(),

sidebarLayout( 
  sidebarPanel(width = 5,
    shinyAce::aceEditor(fontSize = 16, 
                        wordWrap = T,
                        outputId = "fig5plot", 
                        mode = "r", 
                        theme = "github", 
                        height = "450px",
                        value = 
"par(family = 'serif', font = 2)

y <- function(t) { pweibull(t,shape = 1.7,scale = 1) }

curve(pweibull(x,shape=1.7,scale=1),lwd = 2,
      xlab = 't', ylab = 'f(t)', 
      from = 0, to = 3,
      las = 1)

segments(c(0,.5,1,1.5,2,rep(0,5)),
         c(rep(0,5),y(c(0.01,.5,1,1.5,2))),
         c(0,.5,1,1.5,2,rep(2.2,5)),
         rep(y(c(0.01,.5,1,1.5,2)),2),
         lty=rep(2,10),col=rep(1,10))

text(2.3,(y(0.5)+y(.01))/2,expression(pi[1]),cex=1.25)
text(2.3,(y(1.0)+y(0.5))/2,expression(pi[2]),cex=1.25)
text(2.3,(y(1.5)+y(1.0))/2,expression(pi[3]),cex=1.25)
text(2.3,(y(2.0)+y(1.5))/2,expression(pi[4]),cex=1.25)

mtext(side = 3,
      expression('Figure 2.5 - Graphical interpretation of the relationship between the '*pi[i]*' values and F('*t[i]*')'),
      font = 2,line = 2)"),
              actionButton("evalfig5", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("plotfig5", height = "600px"), width = 7)))
