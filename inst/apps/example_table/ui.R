ui = fluidPage(theme = teachingApps::add_themes(getShinyOption("theme")), 
               teachingApps::add_styles(),
               
     mainPanel(width = 12, DT::dataTableOutput('amt')))

