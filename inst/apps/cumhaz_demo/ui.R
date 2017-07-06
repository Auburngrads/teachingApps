ui = navbarPage(title = 'Cumulative Hazard Function',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),

                  
tabPanel('Properties',
         uiOutput('HAZdemo', class = 'ta-text')),

tabPanel('Computing Values in R',
         uiOutput('HAZr', class = 'ta-text')),

tabPanel('Shiny App',                 
   sidebarLayout( 
      sidebarPanel(width = 5,
          shinyAce::aceEditor(fontSize = 16, 
                              wordWrap = T,
                              outputId = "HAZplot", 
                              mode = "r", 
                              theme = "github", 
                              height = "450px", 
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
                              
        actionButton("evalHAZ", "Evaluate")),
                            
        mainPanel(plotOutput("plotHAZ", height = "600px"), width = 7))))
           
