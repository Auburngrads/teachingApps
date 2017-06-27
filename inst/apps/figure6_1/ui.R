library(teachingApps)

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
"par(family='serif',font=2, cex=1.75)

p <- seq(.01,.99,.01)
gamma1 <- 0
theta1 <- 50

gamma2 <- 0
theta2 <-200

plot(qexp(p,rate=1/theta1) - gamma1,-log(1-p),
     type='l', las = 1,
     lwd=2, col=1,
     xlim=range(0,800),
     xlab='Time',
     ylab='Standard Exponential Quantile')

lines(qexp(p,rate=1/theta2) - gamma2, -log(1-p),
      lwd=2, col=2)

text(c(100,650),c(4,2.5), 
     c(expression(theta*', '*gamma*' = 50, 0'),
       expression(theta*', '*gamma*' = 200, 0')))
box(lwd=1.25)"),

        actionButton("evalplots", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("exp", height = "600px"))))
