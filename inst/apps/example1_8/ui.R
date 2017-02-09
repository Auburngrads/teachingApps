library(teachingApps)
library('SMRD')

ui = navbarPage(title = 'Example 1.8',
                collapsible = T, 
                position = 'fixed-top',
                theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
                header = list(tags$head(includeCSS(getShinyOption("CSS"))),
                              tags$head(includeCSS("www/custom.css"))),
                footer = HTML(teachingApps::signature(getShinyOption("appName"))),

tabPanel(h4('Background'),
         mainPanel(uiOutput('example1.8'), class = 'shiny-text-output', width = 12)),
                
tabPanel(h4("Data Set"), 
         titlePanel(HTML('SMRD data object: <code>printedcircuitboard</code>')),
         DT::dataTableOutput("printedcircuitboard", height = "600px")),
                
tabPanel(h4("Figure 1.9"),
  sidebarLayout( 
    sidebarPanel(width = 5,
      shinyAce::aceEditor(fontSize = 16, 
                                     wordWrap = T,
                                     outputId = "fig9plot", 
                          mode = "r", 
                          theme = "github", 
                          height = "450px",
                          value = 
"par(family = 'serif', font = 2)

plot(hoursl~rh, 
     data = SMRD::printedcircuitboard,
     pch = 'X', cex = .85, log = 'y',
     ylim = c(10,10000),xlim = c(45,85))

text(x = c(50,63,75,82), 
     y = c(7000,6000,1000,350), 
     labels = c('48/70 censored',
              '11/68 censored',
              '0/70 censored',
              '0/70 censored'))"),

        actionButton("evalfig9", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("plotfig9", height = "600px"), width = 7))))
