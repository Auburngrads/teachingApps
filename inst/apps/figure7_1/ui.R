library(teachingApps)
library('SMRD')

ui = navbarPage(title = 'Figure 7.1',
                collapsible = T, 
                position = 'fixed-top',
                theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
                header = list(tags$head(includeCSS(getShinyOption("CSS"))),
                              tags$head(includeCSS("www/custom.css"))),
                footer = HTML(teachingApps::signature(getShinyOption("appName"))),
                
tabPanel(h4('Figure 7.1'),
   sidebarLayout(
     sidebarPanel(width = 3,
       selectInput("n7.1", 
                   label = h2("Observations:"),
                   choices = c("20", "200", "2000", "10220"), 
                   selected = "20")),
    
     mainPanel(plotOutput('berkson', height = '600px'), width = 9))),
    
tabPanel(h4('Table 7.1'), DT::dataTableOutput('table.1', height = '80%')),
tabPanel(h4('Code Mirror'), codemirrorR::codemirrorOutput('cm.table.1', 
                                                          height = '600px')))
