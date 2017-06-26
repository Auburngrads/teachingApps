ui = navbarPage(title = 'Cumulative Hazard Function',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_themes(getShinyOption('theme')),
                header = teachingApps::add_styles(),
                footer = teachingApps::add_footer(),

                  
tabPanel(h4('Properties'),
         mainPanel(uiOutput('HAZdemo'), class = 'shiny-text-output', width = 12)),

tabPanel(h4('Computing Values in R'),
         mainPanel(uiOutput('HAZr'), class = 'shiny-text-output', width = 12)),

tabPanel(h4('Shiny App'),                 
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
                              
        actionButton("evalHAZ", h4("Evaluate"), width = '100%')),
                            
        mainPanel(plotOutput("plotHAZ", height = "600px"), width = 7))))
           
