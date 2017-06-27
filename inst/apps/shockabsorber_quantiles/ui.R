ui = fluidPage(theme = teachingApps::add_theme(getShinyOption("theme")), 
               teachingApps::add_style(),
sidebarLayout(
   sidebarPanel(width = 5,
      shinyAce::aceEditor(fontSize = 16, 
                          wordWrap = T,
                          outputId = "shockquant", 
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
               quantile = 0.1, 
               size = 300, 
               zoom.level = 2.25, 
               show.confidence = F,
               original.par = F)

simple.contour(Shock.ld, 
               distribution = 'weibull', 
               quantile = 0.1, 
               profile = 'x', 
               size = 300)

par(mfrow = c(1,1))"),
             
        actionButton("shockquants", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("squant", height = "600px"), width = 7)))
