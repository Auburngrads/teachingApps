library(teachingApps)
library('SMRD')

ui = fluidPage(theme = shinythemes::shinytheme(theme = getShinyOption('theme')),
               tags$head(includeCSS(getShinyOption('css'))),
               tags$footer(getShinyOption('sign')),
               
sidebarLayout(
   sidebarPanel(width = 4,
      shinyAce::aceEditor(fontSize = 16, 
                          wordWrap = T,
                          outputId = "shocksurf", 
                          mode = "r", 
                          theme = "github", 
                          height = "450px", 
                          value = "
par(family = 'serif', mfrow = c(1,2), las = 1, cex = 1.25)

library(SMRD)

zoom <- 1.5

ShockAbsorber.ld <- 
frame.to.ld(SMRD::shockabsorber,
            response.column = 1, 
            censor.column = 3,
            time.units = 'Kilometers')

simple.contour(ShockAbsorber.ld, 
               distribution = 'weibull', 
               rel.or.conf = 'Joint confidence region', 
               factor = zoom,
               original.par = F)

simple.contour(ShockAbsorber.ld, 
               distribution = 'weibull', 
               rel.or.conf = 'Relative likelihood', 
               factor = zoom)

par(mfrow = c(1,1))"),
             
        actionButton("shocksurfs", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("shurf", height = "600px"), width = 8)))
