ui = fluidPage(theme = add_theme(getShinyOption('theme')), 
          add_css(),
               
sidebarLayout( 
  sidebarPanel(width = 5,
     shinyAce::aceEditor(fontSize = 16, 
                         wordWrap = T,
                         outputId = "chazace", 
                         mode = "r", 
                         theme = "github",
                         autoComplete = 'live',
                         height = '500px',
                         value = 
"par(family = 'serif',
     mar = c(4,6,2,1))

f <- function(x) 
       -log(1-pgamma(x, 
                     shape = 3, 
                     rate = 1.5))
         
curve(expr = f(x),
      xlab = 'Time, t',
      ylab = expression(H(t)[Gamma]),
      ylim = c(0,1),
      xlim = c(0,6),
      lwd = 3,
      lty = 5,
      col = 6,
      cex.lab = 1.5,
      cex.axis = 1.5,
      las = 1)"),

     actionButton("chazeval", "Evaluate")),
        
     mainPanel(plotOutput("chazoutput", height = '600px'), width = 7)))
