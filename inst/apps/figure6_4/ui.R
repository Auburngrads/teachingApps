library(teachingApps)
library('SMRD')

ui = fluidPage(theme = teachingApps::add_theme(getShinyOption("theme")), 
               teachingApps::add_style(),

sidebarLayout( 
  sidebarPanel(
    shinyAce::aceEditor(fontSize = 16, 
                        wordWrap = T,
                        outputId = "plots", 
                        mode = "r", 
                        theme = "github", 
                        height = "450px",
                        value = 
"par(family='serif', font=2, cex=1.75)

library(SMRD)

p<- seq(.01,.99,.01)
mean1 <- 40
sdev1 <- 10
mean2 <- 80
sdev2 <- 5

plot(qsev(p, location=mean1, scale=sdev1), qsev(p),
     type='l',
     lwd=2, col=1,
     xlim=range(0,100),
     las = 1,
     xlab='Time',
     ylab='Standard SEV Quantile')

lines(qsev(p,location=mean2, scale=sdev2), qsev(p), lwd=2, col=2)
abline(h=0, lty=2)

text(c(15, 85), c(-1,-2), 
     c(expression(mu*', '*sigma*' = 40, 10'),
       expression(mu*', '*sigma*' = 80, 5')))
box(lwd=1.25)"),

        actionButton("evalplots", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("norm", height = "600px"))))
