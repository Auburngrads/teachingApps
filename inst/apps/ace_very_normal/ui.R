ui = fluidPage(theme = add_theme(getShinyOption('theme')), 
               add_css(),

sidebarLayout(
  sidebarPanel(width = 6,
    shinyAce::aceEditor(fontSize = 16, 
                        wordWrap = T,
                        outputId = "plots", 
                        mode = "r", 
                        theme = "github",
                        value = 
"par(lwd = 2, font = 2, cex = 1.5)

curve(dnorm(x, 4.256432, 0.25), 
      xlim = c(0,10), 
      lwd = 2, 
      lty = 1, 
      col = 1,
      ylab = 'f(time)',
      xlab = 'time',
      las = 1,
      n = 300)
curve(dnorm(x, 4.256432, 1.0), 
      lty = 2, 
      col = 2, 
      add = T)
curve(dnorm(x, 4.256432, 2.0),
      lty = 3, 
      col = 3, 
      add = T)
curve(dnorm(x, 4.256432, 3.0),
      lty = 4, 
      col = 4, 
      add = T)
curve(dnorm(x, 4.256432, 5.0),
      lty = 5, 
      col = 5, 
      add = T)
abline(v = 4.256432)
legend(x = 7, 
       y = 1.5,
       legend = c(expression(sigma==0.25),
                  expression(sigma==1.00),
                  expression(sigma==2.00),
                  expression(sigma==3.00),
                  expression(sigma==5.00)),
       lty = 1:5,
       col = 1:5,
       lwd = 2,
       bty = 'n', 
       y.intersp = 0.75)"),

        actionButton("evalplots", "Evaluate")),
        
        mainPanel(plotOutput("exp"), width = 6)))

