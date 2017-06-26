ui = fluidPage(theme = teachingApps::add_themes(getShinyOption("theme")), 
               teachingApps::add_styles(),
               
     mainPanel(networkD3::sankeyNetworkOutput('sankey1')))

