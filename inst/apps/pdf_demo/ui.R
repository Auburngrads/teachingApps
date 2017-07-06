ui = navbarPage(title = 'Density Function',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),

                
tabPanel('Properties',
         uiOutput('pdfdemo', class = 'ta-text')),

tabPanel('Computing Values in R',
         uiOutput('pdfr', class = 'ta-text')),
                    
tabPanel('Shiny App',
  sidebarLayout(
    sidebarPanel(
      shinyAce::aceEditor(fontSize = 16, 
                          wordWrap = T,
                          outputId = "pdfplot", 
                          mode = "r", 
                          theme = "github", 
                          height = "450px", 
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

        actionButton("evalpdf", "Evaluate")),
        
        mainPanel(plotOutput("plotpdf", height = "600px")))))
