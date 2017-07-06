ui = fluidPage(theme = add_theme(getShinyOption('theme')), 
               add_css(),

sidebarLayout(
  sidebarPanel(width = 5,
    shinyAce::aceEditor(fontSize = 16, 
                        wordWrap = T,
                        outputId = "censorplot", 
                        mode = "r", 
                        theme = "github", 
                        value = "
par(family = 'serif', font = 2)

curve(dweibull(x, shape = 1.7, scale = 1),
      lwd = 2,
      las = 1, 
      xlim = c(0,2.5),
      xlab = 'Time (t)',
      ylab = 'f(t)',
      main = 'Figure 2.6 - Likelihood contributions for different kids of censoring')

polygon(x = c(seq(0,.5,.01),.5),
        y = c(dweibull(seq(0,.5,.01),shape = 1.7,scale = 1),0),
        col = 1)
polygon(x = c(1,seq(1,1.5,.01),1.5),
        y = c(0,dweibull(seq(1,1.5,.01),shape = 1.7,scale = 1),0),
        col = 1)
polygon(x = c(2,seq(2,2.4,.01),2.4),
        y = c(0,dweibull(seq(2,2.4,.01),shape = 1.7,scale = 1),0),
        col = 1)

text(x = c(.16,1.3,2.2),
     y = c(.75,.65,.15),
     labels = c('Left Censoring',
                'Interval Censoring',
                'Right Censoring'))"),

   actionButton("evalcensor", "Evaluate")),

   mainPanel(plotOutput('plotcensor', height = '600px'), width = 7)))
