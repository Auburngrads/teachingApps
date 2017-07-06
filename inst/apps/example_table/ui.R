ui = fluidPage(theme = add_theme(getShinyOption('theme')), 
               add_css(),
               
     mainPanel(width = 12, DT::dataTableOutput('amt')))

