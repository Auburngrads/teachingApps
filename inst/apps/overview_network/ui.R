ui = fluidPage(theme = add_theme(getShinyOption('theme')), 
               add_css(),
               
      mainPanel(visNetwork::visNetworkOutput('visnet1',height = '600px'),
                width = 12))
