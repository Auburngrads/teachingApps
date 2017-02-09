library(teachingApps)
library('SMRD')

ui = fluidPage(theme = shinythemes::shinytheme(theme = getShinyOption("theme")), 
               tags$head(includeCSS(getShinyOption("CSS"))),
               tags$head(includeCSS("www/custom.css")),
               tags$footer(getShinyOption("sign")),

sidebarLayout(
   sidebarPanel(width = 4,
      shinyAce::aceEditor(fontSize = 16, 
                          wordWrap = T,
                          outputId = "shockprof", 
                          mode = "r", 
                          theme = "github", 
                          height = "450px", 
                          value = "
par(family = 'serif', mfrow = c(1,2), las = 1, cex = 1.25)

library(SMRD)

ShockAbsorber.ld <- 
frame.to.ld(SMRD::shockabsorber,
            response.column = 1, 
            censor.column = 3,
            time.units = 'Kilometers')

simple.contour(ShockAbsorber.ld, 
               distribution = 'weibull', 
               profile = 'x', 
               size = 300,
               print.ci = F)

simple.contour(ShockAbsorber.ld, 
               distribution = 'weibull', 
               profile = 'y', 
               size = 300,
               print.ci = F)

par(mfrow = c(1,1))"),
             
        actionButton("shockprofs", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("shorf", height = "600px"), width = 8)))
