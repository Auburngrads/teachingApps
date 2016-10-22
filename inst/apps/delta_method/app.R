library(teachingApps)
library(SMRD)

shinyApp(options = list(width = "100%", height = "800px"), 
ui = navbarPage(position = 'fixed-top',
                collapsible = T, 
                title = 'The Delta Method',
                theme = shinythemes::shinytheme(theme = source('www/args.R')[[1]]$theme),
                header = tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
                footer = HTML(teachingApps::teachingApp(source('www/args.R')[[1]]$appName)),
                
tabPanel(h4('Background'),
         mainPanel(uiOutput('delta'), class = 'shiny-text-output', width = 12)),

tabPanel(h4('Example'),
         mainPanel(uiOutput('greenwood'), class = 'shiny-text-output', width = 12))),

server = function(input, output, session) {
  
output$delta <- renderUI({ 
  withMathJax(HTML(includeMarkdown('background.Rmd')))
})

output$greenwood <- renderUI({ 
  withMathJax(HTML(includeMarkdown('greenwood.Rmd')))
})
})
