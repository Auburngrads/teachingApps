ui = fluidPage(theme = add_theme(getShinyOption('theme')), 
               add_css(),
               
     mainPanel(networkD3::sankeyNetworkOutput('sankey1')))

