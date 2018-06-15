ui = fluidPage(theme = add_theme(getShinyOption('theme')), 
          add_css(),
               
sidebarLayout( 
  sidebarPanel(width = 5,
     shinyAce::aceEditor(fontSize = 16, 
                         wordWrap = T,
                         outputId = "hazace", 
                         mode = "r", 
                         theme = "github",
                         autoComplete = 'live',
                         height = '500px',
                         value = 
"par(family = 'serif',mar = c(4,6,2,1))

curve(
dlnorm(x, meanlog = log(1.25), sdlog = 1)/
(1-plnorm(x, meanlog = log(1.25), sdlog = 1)),
xlab = 'Time, t',
ylab = expression(h(t)[Log-Normal]),
ylim = c(0,1),
xlim = c(0,6),
lwd = 3,
lty = 4,
col = 5,
cex.lab = 1.5,
cex.axis = 1.5,
las = 1)"),

     actionButton("hazeval", "Evaluate")),
        
     mainPanel(plotOutput("hazoutput", height = '600px'), width = 7)))
