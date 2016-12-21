library(teachingApps)
library('visNetwork')

ui = fluidPage(theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
               tags$head(includeCSS(getShinyOption("css"))),
               
      mainPanel(visNetwork::visNetworkOutput('visnet1',height = '600px'),width = 12))
