library(teachingApps)
library(package = 'SMRD')

ui = fluidPage(theme = teachingApps::add_theme(getShinyOption("theme")), 
               teachingApps::add_style(),

sidebarLayout( 
  sidebarPanel(width = 5,
    shinyAce::aceEditor(fontSize = 16, 
                        wordWrap = T,
                        outputId = "fig1plot", 
                        mode = "r", 
                        theme = "github", 
                        height = "450px",
                        value = 
"par(family = 'serif',font = 2)

library(package = SMRD)

distribution.plot('Weibull',
                  shape = c(1.7), 
                  scale = 1,
                  prob.range=c(.000001,.99))"),

        actionButton("evalfig1", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("plotfig1", height = "600px"), width = 7)))
