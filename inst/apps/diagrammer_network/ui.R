library(teachingApps)
library(DiagrammeR)

ui <- fluidPage(theme = shinythemes::shinytheme(theme = getShinyOption("theme")), 
                tags$head(includeCSS(getShinyOption("css"))),
                tags$footer(getShinyOption("sign")),
               
sidebarLayout(
   sidebarPanel(width = 4),
      mainPanel(grVizOutput('grtest'))))
