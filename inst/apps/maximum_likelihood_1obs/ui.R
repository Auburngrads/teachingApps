ui = fluidPage(titlePanel('To change the plot update the code and click "Evaluate" '),
               theme = add_theme(getShinyOption('theme')), 
               add_css(),

                 
sidebarLayout(
   sidebarPanel(width = 5,
      shinyAce::aceEditor(fontSize = 16, 
                          wordWrap = T,
                          outputId = "likeplot", 
                          mode = "r", 
                          theme = "github", 
                          height = "450px", 
                          value ="
par(family = 'serif', mar = c(4,4,1,2))

curve(dexp(x, rate = 1), 
      lwd = 2, col = 1, 
      xlim = c(0,5), 
      ylim = range(0,.8), 
      xlab = 'Time (t)', 
      ylab = 'f(t)',
      las = 1, 
      cex.lab = 1.5,
      cex.axis = 1.5)

curve(dweibull(x, shape = 1.5), lwd = 2, col = 4, lty = 2, add = T)

points(x = c(0.5,0.5),
       y = c(dexp(0.5, rate = 1), dweibull(0.5,shape = 1.5)), 
       cex = 1.5, 
       pch = 16, 
       col = 2)

text(x = c(0.5,0.5),
     y = c(dweibull(0.5, shape = 1.5)+.005,
           dexp(0.5, rate = 1)+.005),
     labels = c(parse(text = paste('NA%<-%~',dweibull(0.5, shape = 1.5))),
                parse(text = paste('NA%<-%~',dexp(0.5, rate = 1)))),
     adj = -0.15,
     cex = 1.5)

abline(v = 0.5, col = 2)

legend('topright',
       c(parse(text = 'exp(theta==1)'),
         parse(text = 'Weib(beta,theta==1.5,1)')), 
       lwd = 2, 
       col = c(1,4), 
       bty = 'n', 
       lty = c(1,2),
       y.intersp = 1.5,
       cex = 1.4)

text(x = 2, 
     y = 0.5, 
     'Each observation contributes to the total likelihood function\n
In this figure a single observation of t = 0.5 results in a greater 
likelihood contribution for the Weibull distributon 
than for the exponential distribution', 
      cex = 1.5, 
      adj = 0)"),

   actionButton("evallike", "Evaluate")),

   mainPanel(plotOutput('plotlike', height = '600px'), width = 7)))



