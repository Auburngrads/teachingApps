library(teachingApps)













shinyApp(options = list(height = '550px'),
         
  ui = fluidPage(theme = shinythemes::shinytheme(theme = global$theme),
                  tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
        mainPanel(width = 12, DT::dataTableOutput('amt')),
        
fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px')),

server = function(input, output, session) {

  output$sign <- renderUI({HTML(teachingApps::teachingApp(global$appName))})
    
    output$amt <- DT::renderDataTable({
      
      DT::datatable(mtcars, 
                    options = list(pageLength = 8))
})
})
