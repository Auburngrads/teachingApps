ui = fluidPage(theme = teachingApps::add_themes(getShinyOption("theme")), 
               teachingApps::add_styles(),
               
      mainPanel(visNetwork::visNetworkOutput('visnet1',height = '600px'),width = 12))
