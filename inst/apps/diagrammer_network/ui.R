library(teachingApps)
library(DiagrammeR)

ui <- fluidPage(theme = shinythemes::shinytheme(theme = getShinyOptions("theme")), 
                tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
               
sidebarLayout(
   sidebarPanel(width = 4),
      mainPanel(grVizOutput('grtest'))),

if(!getShinyOptions("story"))
fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px'))
