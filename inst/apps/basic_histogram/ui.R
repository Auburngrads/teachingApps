library(teachingApps)

ui = fluidPage(theme = shinythemes::shinytheme(theme = getShinyOption("theme")), 
               tags$head(includeCSS(getShinyOption("CSS"))),
               tags$head(includeCSS("www/custom.css")),
               tags$footer(getShinyOption("sign")),
               
sidebarLayout( 
  sidebarPanel(width = 5,
     shinyAce::aceEditor(fontSize = 16, 
                         wordWrap = T,
                         outputId = "code", 
                         mode = "r", 
                         theme = "github",
                         autoComplete = 'live',
                         height = '500px',
                         value = 
"set.seed(NULL)

x <- rbinom(500,size = 15,p = .25)

hist(x, 
     col = 1,
     border = 'orange',
     breaks = 0:11,
     main = '',
     probability = T,
     las = 1)"),

     actionButton("eval", h4("Evaluate"), width = '100%')),
        
     mainPanel(plotOutput("output", height = '600px'), width = 7)))
