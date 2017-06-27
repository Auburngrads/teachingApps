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
"par(family='serif',font=2,cex=1.75)
p <- seq(.01,.99,.01)
meanlog1 <- log(50)
sdlog1 <- 2
meanlog2 <- log(500)
sdlog2 <- 2
meanlog3 <- log(500)
sdlog3 <- 1

plot(qlnorm(p,meanlog = meanlog1, 
              sdlog = sdlog1),
     qnorm(p),
     type='l',
     lwd=2,
     xlim=c(1,1000),
     las = 1,
     xlab='Time',
     ylab='Standard Normal Quantile',
     log='x')

lines(qlnorm(p,meanlog = meanlog2, sdlog = sdlog2), 
      qnorm(p), lwd=2, col=2)

lines(qlnorm(p,meanlog = meanlog3, sdlog = sdlog3), 
      qnorm(p), lwd=2, col=3)
abline(h=0, lty=2)

box(lwd=1.25)

legend('topleft',
       c(expression('exp('*mu*'),'*sigma*' = 50,2'),
         expression('exp('*mu*'),'*sigma*' = 500,2'),
         expression('exp('*mu*'),'*sigma*' = 500,1')),
       lty = 1,col = c(1:3),lwd = 2, bty = 'n')"),
              actionButton("evalplots", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("lnorm", height = "600px"))))
