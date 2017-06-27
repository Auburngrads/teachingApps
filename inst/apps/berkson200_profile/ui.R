ui = fluidPage(theme = teachingApps::add_theme(getShinyOption("theme")), 
               teachingApps::add_style(),
      
sidebarLayout(
   sidebarPanel(width = 5,
      shinyAce::aceEditor(fontSize = 16, 
                          wordWrap = T,
                          outputId = "berkprofile200", 
                          mode = "r", 
                          theme = "github", 
                          height = "450px", 
                          value = 
"par(family  = 'serif')

library(SMRD)

berkson200.ld <- 
frame.to.ld(berkson200a,
            response.column = c(1,2),
            censor.column = 3,
            case.weight.column = 4,
            time.units = '1/5000 Seconds')

simple.contour(berkson200.ld, 
               distribution = 'exponential', 
               xlim = c(450,800))"),

        actionButton("berk200profiles", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("berk200prof", height = "600px"), width = 7)))
