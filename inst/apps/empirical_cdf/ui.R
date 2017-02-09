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
                        height = '500px',
                        value = 
"beta <- 2
theta <- 15

v <- rweibull(100, shape = beta, scale = theta)

plot(ecdf(v),
     xlab = '', 
     main = '',
     col = 'blue')

curve(pweibull(x, shape = beta, scale = theta), 
      add = TRUE,
      lwd = 2,
      col = 2)

axis(side = 1, at = v, labels = F)"),

          actionButton("eval", h3("Evaluate"))),
        
          mainPanel(plotOutput("output", height = '600px'), width = 7)))
