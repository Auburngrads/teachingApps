










get('arg2', envir = .GlobalEnv, inherits = T)

shinyApp(options = list(height = '550px'),
         
  ui = fluidPage(theme = shinythemes::shinytheme(theme = arg2$theme),
                 try(includeCSS(system.file('css',
                                           'my-shiny.css', 
                                           package = 'teachingApps')), silent = T),
        mainPanel(width = 12, DT::dataTableOutput('amt')),
        
fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px')),

server = function(input, output, session) {

  output$sign <- renderUI({HTML(teachingApps::teachingApp(arg2$appName))})
    
    output$amt <- DT::renderDataTable({
      
      DT::datatable(mtcars, 
                    options = list(pageLength = 8))
})
})
