ui = fluidPage(theme = add_theme(getShinyOption('theme')), 
               add_css(),
               
  sidebarLayout(
     sidebarPanel(width = 5,
        shinyAce::aceEditor(fontSize = 16, 
                            wordWrap = T,
                            outputId = "pdflikeplot", 
                            mode = "r", 
                            theme = "github", 
                            height = "450px", 
                            value =
"par(mfrow = c(1,2), mar = c(4,4,2,0))

n = 50

x.lnor <- rlnorm(n = n, 
                 meanlog = 4.5, 
                 sdlog = .2)
x.weib <- rweibull(n = n, 
                   scale = 120, 
                   shape = 5.5)
x.exp  <- rexp(n = n, 
               rate = 1/40)

curve(dlnorm(x, meanlog = 4.5, sdlog = 0.2), 
      xlim = c(0,200), 
      las = 1, 
      lwd = 2, 
      bty = 'l',
      xlab = 't', 
      ylab = 'f(t)')

curve(dweibull(x, scale = 120, shape = 5.5), 
      add = TRUE, 
      lwd = 2, 
      col = 2)

curve(dexp(x, rate = 1/40), 
      add = TRUE, 
      lwd = 2, 
      col = 'green')

points(x = x.weib, 
       y = dweibull(x.weib, shape = 5.5, scale = 120), 
       col = 2, pch = 16, cex = 1.5)
points(x = x.exp, 
       y = dexp(x.exp,rate = 1/40), 
       col = 'green', pch = 16, cex = 1.5)
points(x = x.lnor, 
       y = dlnorm(x.lnor,meanlog = 4.5, sdlog = 0.2), 
       pch = 16, cex = 1.5)

plot(x = x.lnor, 
     y = rep(1,n), 
     xlab = 'Observed Values',
     col = 1, pch = 16, 
     ylim = c(0,6), xlim = c(0,200), 
     yaxt = 'n', ylab = '', 
     bty = 'n', cex = 1.5)

points(x = x.weib,
       y = rep(3,n), 
       col = 2, pch = 16, cex = 1.5)
points(x = x.exp, 
       y = rep(5,n), 
       col = 'green', pch = 16, cex = 1.5)

axis(side = 1, at = x.lnor, col = 1, labels = FALSE, tck = .05 )
axis(side = 1, at = x.weib, col = 2, labels = FALSE, tck = .05 )
axis(side = 1, at = x.exp,  col = 'green', labels = FALSE, tck = .05 )
par(mfrow = c(1,1))"),

   actionButton("evalpdflike", "Evaluate")),

   mainPanel(plotOutput('plotpdflike', height = '600px'), width = 7)))
