ui = navbarPage(title = 'Density Function',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_style(),
                footer = teachingApps::add_stamp(),

                
tabPanel(h4('Properties'),
         mainPanel(uiOutput('pdfdemo'), class = 'shiny-text-output', width = 12)),

tabPanel(h4('Computing Values in R'),
         mainPanel(uiOutput('pdfr'), class = 'shiny-text-output', width = 12)),
                    
tabPanel(h4('Shiny App'),
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

        actionButton("evalpdf", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("plotpdf", height = "600px")))))
