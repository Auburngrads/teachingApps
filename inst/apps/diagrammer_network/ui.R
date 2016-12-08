library(teachingApps)
library(DiagrammeR)

ui <- fluidPage(theme = shinythemes::shinytheme(theme = global$theme), 
                tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
               
sidebarLayout(
   sidebarPanel(width = 4),
      mainPanel(grVizOutput('grtest'))),

if(!global$story)
fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px'))
