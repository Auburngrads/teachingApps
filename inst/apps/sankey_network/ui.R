library(teachingApps)
library('networkD3')
library('d3Network')

ui = fluidPage(theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
               tags$head(includeCSS("www/custom.css")),
               
     mainPanel(networkD3::sankeyNetworkOutput('sankey1')))

