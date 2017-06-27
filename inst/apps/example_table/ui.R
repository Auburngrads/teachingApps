ui = fluidPage(theme = teachingApps::add_theme(getShinyOption("theme")), 
               teachingApps::add_style(),
               
     mainPanel(width = 12, DT::dataTableOutput('amt')))

