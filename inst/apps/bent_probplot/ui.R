ui = fluidPage(theme = teachingApps::add_theme(getShinyOption("theme")), 
               teachingApps::add_css(),
  
sidebarLayout(
  sidebarPanel(width = 5,
    shinyAce::aceEditor(fontSize = 16, 
                        wordWrap = T,
                        outputId = "bleedplot", 
                        mode = "r", 
                        theme = "github", 
                        height = "450px",
                        value = 
"par(family = 'serif',
     font = 2, cex = 1.75)

Bleed.ld <- 
frame.to.ld(bleed,
            response.column = 1, 
            censor.column = 2, 
            case.weight.column = 3,
            x.columns = c(4),
            time.units = 'Hours')

plot(Bleed.ld,
     distribution = NULL)"),

        actionButton("evalbleedplot", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("bleedplot", height = "600px"), width = 7)))


