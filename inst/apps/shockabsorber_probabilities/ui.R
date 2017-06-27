ui = fluidPage(theme = teachingApps::add_theme(getShinyOption("theme")), 
               teachingApps::add_style(),
               
sidebarLayout(
  sidebarPanel(width = 4,
    shinyAce::aceEditor(fontSize = 16, 
                        wordWrap = T,
                        outputId = "shockprob", 
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
               the.quantile = 0.1, 
               size = 300, 
               factor = 2.25, 
               rel.or.conf = 'Relative likelihood',
               original.par = F)

simple.contour(ShockAbsorber.ld, 
               distribution = 'weibull', 
               the.quantile = 0.1, 
               profile = 'x', 
               size = 300)

par(mfrow = c(1,1))"),
             
        actionButton("shockprobs", h4("Evaluate"),width = '100%')),
        
        mainPanel(plotOutput("sprob", height = "600px"), width = 8)))
