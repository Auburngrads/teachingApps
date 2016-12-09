library(teachingApps)
library('SMRD')

shinyApp(options = list(height = "800px"),
         onStart = function() { options('markdown.HTML.stylesheet' = system.file('css','my-shiny.css', package = 'teachingApps'))}, 
ui = navbarPage(position = 'fixed-top',
                collapsible = T, 
                title = 'R Package: SMRD',
                theme = shinythemes::shinytheme(theme = getShinyOptions("theme")),
                header = tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
                footer = HTML(teachingApps::teachingApp(getShinyOptions("appName"))),
                
tabPanel(h4('Background'),
         mainPanel(uiOutput('smrd.back'), class = 'shiny-text-output', width = 12)),

tabPanel(h4('Features'),
         mainPanel(uiOutput('smrd.feat'), class = 'shiny-text-output', width = 12)),
                
tabPanel(h4("Data Sets"), DT::dataTableOutput("smrd.data", height = "600px")),

tabPanel(h4('Vignettes'),
         mainPanel(uiOutput('smrd.vign'), class = 'shiny-text-output', width = 12))),

server = function(input, output, session) {
  
output$smrd.back <- renderUI({ 
  withMathJax(HTML(includeMarkdown('background.Rmd')))
})

output$smrd.feat <- renderUI({ 
  withMathJax(HTML(includeMarkdown('features.Rmd')))
})

output$smrd.data <- DT::renderDataTable({ 
  DT::datatable(data(package = 'SMRD')$results[,3:4],
                options = list(pageLength = 10)) 
})
output$smrd.vign <- renderUI({ 
  withMathJax(HTML(includeMarkdown('vignettes.Rmd')))
})

})
