ui = navbarPage(title = 'Quantile Function',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),


tabPanel('Properties',
         uiOutput('quandemo', class = 'ta-text')),

tabPanel('Computing Values in R',
         uiOutput('quanr', class = 'ta-text')),
                
navbarMenu('Plots', icon = icon('bar-chart-o'),                
                
tabPanel("Quantile Function Plot",
  sidebarLayout( 
    sidebarPanel(width = 5,
      shinyAce::aceEditor(fontSize = 16, 
                          wordWrap = T,
                          outputId = "quantplot", 
                          mode = "r", 
                          theme = "github", 
                          height = "450px", 
                          value = 
"par(family = 'serif',mar = c(4,6,2,1))

curve(qweibull(x,shape = 1.7, scale = 1),
      xlab = expression(F**-1*(t)[Weibull]),
      ylab = 'Time, t',
      ylim = c(0,3),
      xlim = c(0,1),
      lwd = 3,
      lty = 1,
      col = 2,
      cex.lab = 1.5,
      cex.axis = 1.5,
      las = 1)"),

        actionButton("evalquant", "Evaluate")),
        
        mainPanel(plotOutput("plotquant", height = "600px"), width = 7))),
                
tabPanel("Figure 2.3",
  sidebarLayout( 
    sidebarPanel(width = 5,
      shinyAce::aceEditor(fontSize = 16, 
                          wordWrap = T,
                          outputId = "fig3plot", 
                          mode = "r", 
                          theme = "github", 
                          height = "450px",
                          value = 
"par(mfrow = c(1,2),family = 'serif', font = 2)

x <- seq(0,2.4,by = .01)
y <- pweibull(seq(0,2.4,by = .01), shape = 1.7, scale = 1)
z <- dweibull(seq(0,2.4,by = .01), shape = 1.7, scale = 1)

plot(x = x, 
     y = z, 
     type = 'l',
     lwd = 1.25, 
     xlab = 't', 
     ylab = 'f(t)',
     main = 'Probability Density Function', 
     las = 1)
polygon(c(seq(0,.4,.01),.4),\nc(dweibull(seq(0,.4,.01),shape=1.7,scale=1),0),\ncol='black')
text(x = 1.25,
     y = .1,
     labels = 'Shaded Area = 0.2')

plot(x = x, 
     y = y, 
     type = 'l',
     lwd = 1.25,
     xlab = 't', 
     ylab = 'F(t)',
     main = 'Cumulative Distribution Function', 
     las = 1)
arrows(c(0,qweibull(.2,shape=1.7,scale=1)),c(.2,.2),
       c(qweibull(.2,sh=1.7,sc=1),
       qweibull(.2,sh=1.7,sc=1)),c(.2,0),
       lwd=.5)

par(mfrow = c(1,1))
mtext(side = 1,
      'Figure 2.3 - Plots showing that the quantile function is the inverse of the cdf',\nline = 4)"),

        actionButton("evalfig3", "Evaluate")),
        
        mainPanel(plotOutput("plotfig3", height = "600px"), width = 7)))))
