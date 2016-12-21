library(teachingApps)
library(DiagrammeR)

ui <- fluidPage(theme = shinythemes::shinytheme(theme = getShinyOption("theme")), 
                tags$head(includeCSS(getShinyOption("css"))),
               
sidebarLayout(
   sidebarPanel(width = 4),
      mainPanel(grVizOutput('grtest'))),

if(!getShinyOption("story"))
fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px'))
