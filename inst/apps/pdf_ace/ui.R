ui = fluidPage(theme = add_theme(getShinyOption('theme')), 
          add_css(),
               
sidebarLayout( 
  sidebarPanel(width = 5,
     shinyAce::aceEditor(fontSize = 16, 
                         wordWrap = T,
                         outputId = "pdface", 
                         mode = "r", 
                         theme = "github",
                         autoComplete = 'live',
                         height = '500px',
                         value = 
"par(family = 'serif',mar = c(4,6,2,1))

curve(dexp(x,rate = 1.7),
      xlab = 'Time, t',
      ylab = expression(f(t)[Exponential]),
      xlim = c(0,3),
      lwd = 3,
      lty = 2,
      col = 3,
      cex.lab = 1.5,
      cex.axis = 1.5,
      las = 1)"),

     actionButton("pdfeval", "Evaluate")),
        
     mainPanel(plotOutput("pdfoutput", height = '600px'), width = 7)))
