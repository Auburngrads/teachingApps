ui = fluidPage(theme = teachingApps::add_themes(getShinyOption("theme")), 
               teachingApps::add_styles(),
               
sidebarLayout(
   sidebarPanel(width = 4),
      mainPanel(grVizOutput('grtest'))))
