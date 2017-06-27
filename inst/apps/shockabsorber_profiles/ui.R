ui = fluidPage(theme = teachingApps::add_theme(getShinyOption("theme")), 
               teachingApps::add_style(),
               
sidebarLayout(
   sidebarPanel(width = 5,
      shinyAce::aceEditor(fontSize = 16, 
                          wordWrap = T,
                          outputId = "shockprof", 
                          mode = "r", 
                          theme = "github", 
                          height = "450px", 
                          value = "
par(mfrow = c(1,2), las = 1)

library(SMRD)

Shock.ld <- 
frame.to.ld(shockabsorber,
            response.column = 1, 
            censor.column = 3,
            time.units = 'Kilometers')

simple.contour(Shock.ld, 
               distribution = 'weibull', 
               profile = 'x', 
               size = 300,
               print.ci = F)

simple.contour(Shock.ld, 
               distribution = 'weibull', 
               profile = 'y', 
               size = 300,
               print.ci = F)

par(mfrow = c(1,1))"),
             
        actionButton("shockprofs", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("shorf", height = "600px"), width = 7)))
