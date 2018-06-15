ui = fluidPage(theme = add_theme(getShinyOption('theme')), 
          add_css(),
               
sidebarLayout( 
  sidebarPanel(width = 5,
     shinyAce::aceEditor(fontSize = 16, 
                         wordWrap = T,
                         outputId = "quanace", 
                         mode = "r", 
                         theme = "github",
                         autoComplete = 'live',
                         height = '500px',
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

     actionButton("quaneval", "Evaluate")),
        
     mainPanel(plotOutput("quanoutput", height = '600px'), width = 7)))
