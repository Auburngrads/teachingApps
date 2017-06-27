library(teachingApps)
library('SMRD')

ui = fluidPage(theme = teachingApps::add_theme(getShinyOption("theme")), 
               teachingApps::add_style(),

sidebarLayout(
  sidebarPanel(
    shinyAce::aceEditor(fontSize = 16, 
                        wordWrap = T,
                        outputId = "npplot", 
                        mode = "r", 
                        theme = "github", 
                        height = "475px", 
                        value = 
"par(family = 'serif', font = 2, cex = 1.15)

library(SMRD)

HE.ld <- frame.to.ld(SMRD::heatexchanger,
                     response.column = c(1,2), 
                     censor.column = 3,
                     case.weight.column = 4,
                     time.units = 'Years')

plot(HE.ld,band.type = 'Pointwise')"),

        actionButton("eval3.2", h4("Evaluate"),width = '100%')),
        
        mainPanel(plotOutput("plot3.2", height = "600px"))))
