library(teachingApps)
library('visNetwork')

ui = fluidPage(theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
               tags$head(includeCSS("www/custom.css")),
               
      mainPanel(visNetwork::visNetworkOutput('visnet1',height = '600px'),width = 12))
