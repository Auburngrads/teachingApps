library(teachingApps)
library(SMRD)

ui = fluidPage(theme = shinythemes::shinytheme(theme = global$theme), 
               tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
               
sidebarLayout(
  sidebarPanel(width = 5,
     shinyAce::aceEditor(fontSize = 16, 
                         wordWrap = T,
                         outputId = "eventplots", 
                         mode = "r", 
                         theme = "github", 
                         height = "450px",
                         value = 
"library(SMRD)

lfp1370.ld <- 
frame.to.ld(SMRD::lfp1370,
            response.column = 1, 
            censor.column = 2, 
            case.weight.column = 3,
            time.units = 'Hours')

turbine.ld <- 
frame.to.ld(SMRD::turbine,
            response.column = 1, 
            censor.column = 2,
            case.weight.column = 3,
            time.units = 'Hundreds of Hours')

par(mfrow = c(1,2),family = 'serif',font = 2)

event.plot(lfp1370.ld)
event.plot(turbine.ld) 

par(mfrow = c(1,1))"),

        actionButton("evaleventplots", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("ploteventplots", height = "600px"), width = 7)),

if(!global$story) 
fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px'))
