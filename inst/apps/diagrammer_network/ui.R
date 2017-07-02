ui = fluidPage(theme = teachingApps::add_theme(getShinyOption("theme")), 
               teachingApps::add_css(),
               
sidebarLayout(
   sidebarPanel(width = 4),
      mainPanel(grVizOutput('grtest'))))
