library(teachingApps)
library('visNetwork')

ui = fluidPage(theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
               tags$head(includeCSS(getShinyOption("css"))),
               tags$footer(getShinyOption("sign")),
               
mainPanel(width = 12,
   tabsetPanel(type = 'pills',
     tabPanel(h4('Data Analysis'),           
              visNetworkOutput("stats",height = "600px")),
     tabPanel(h4('Programming'),             
              visNetworkOutput("coding",height = "600px")),
     tabPanel(h4('Data Munging'),            
              visNetworkOutput("munging",height = "600px")),
     tabPanel(h4('Reproducible Research'),   
              visNetworkOutput("reproduce",height = "600px")),
     tabPanel(h4('Web Development'),         
              visNetworkOutput("webdev",height = "600px")),
     tabPanel(h4('This Course'),             
              visNetworkOutput("stat687",height = "600px")))))
