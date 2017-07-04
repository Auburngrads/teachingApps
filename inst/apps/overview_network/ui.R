ui = fluidPage(theme = teachingApps::add_theme(getShinyOption("theme")), 
               teachingApps::add_css(),
               
      mainPanel(visNetwork::visNetworkOutput('visnet1',height = '600px'),
                width = 12))
