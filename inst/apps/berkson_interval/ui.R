ui = fluidPage(titlePanel('To change the plot update the code and click "Evaluate" '),
               theme = teachingApps::add_theme(getShinyOption("theme")), 
               teachingApps::add_style(),

               
sidebarLayout(
  sidebarPanel(width = 5,
  shinyAce::aceEditor(fontSize = 16, 
                      wordWrap = T,
                      outputId = "berkint", 
                      mode = "r", 
                      theme = "github", 
                      height = "450px", 
                      value = "
par(family = 'serif', 
    mfrow = c(1,2), 
    las = 1, 
    cex = 1.25)

library(SMRD)

zoom <- 1.5

Berkson200.ld <- 
frame.to.ld(SMRD::berkson200a,
            response.column = c(1,2), 
            censor.column = 3,
            case.weight.column = 4)

simple.contour(Berkson200.ld, 
               distribution = 'exponential', 
               xlim = c(400,800),
               original.par = F)

simple.contour(Berkson200.ld, 
               distribution = 'weibull', 
               show.confidence = F, 
               zoom.level = zoom)

par(mfrow = c(1,1))"),

        actionButton("berks", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("berkint", height = "600px"), width = 7)))

