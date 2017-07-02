ui = fluidPage(theme = teachingApps::add_theme(getShinyOption("theme")), 
               teachingApps::add_css(),
               
     mainPanel(networkD3::sankeyNetworkOutput('sankey1')))

