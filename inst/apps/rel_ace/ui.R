ui = fluidPage(theme = add_theme(getShinyOption('theme')), 
          add_css(),
               
sidebarLayout( 
  sidebarPanel(width = 5,
     shinyAce::aceEditor(fontSize = 16, 
                         wordWrap = T,
                         outputId = "relace", 
                         mode = "r", 
                         theme = "github",
                         autoComplete = 'live',
                         height = '500px',
                         value = 
"par(family = 'serif',mar = c(4,6,2,1))

curve(
expr = 1-pnorm(x, mean = 3, sd = 1),
xlab = 'Time, t',
ylab = expression(S(t)[Normal]),
ylim = c(0,1),
xlim = c(0,6),
lwd = 3,
lty = 3,
col = 4,
cex.lab = 1.5,
cex.axis = 1.5,
las = 1)"),

     actionButton("releval", "Evaluate")),
        
     mainPanel(plotOutput("reloutput", height = '600px'), width = 7)))
