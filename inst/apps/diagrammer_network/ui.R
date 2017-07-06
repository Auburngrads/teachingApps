ui = fluidPage(theme = add_theme(getShinyOption('theme')), 
               add_css(),
               
sidebarLayout(
   sidebarPanel(width = 4),
      mainPanel(grVizOutput('grtest'))))
