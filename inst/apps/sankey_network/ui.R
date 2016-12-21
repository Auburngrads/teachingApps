library(teachingApps)
library('networkD3')
library('d3Network')

ui = fluidPage(theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
               tags$head(includeCSS(getShinyOption("css"))),
               
     mainPanel(networkD3::sankeyNetworkOutput('sankey1')))

