library(teachingApps)
library(SMRD)

shinyApp(options = list(height = "800px"),
         onStart = function() { options('markdown.HTML.stylesheet' = system.file('css','my-shiny.css', package = 'teachingApps'))}, 
ui = navbarPage(position = 'fixed-top',
                collapsible = T, 
                title = 'The Delta Method',
                theme = shinythemes::shinytheme(theme = global$theme),
                header = tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
                footer = HTML(teachingApps::teachingApp(global$appName)),
                
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
