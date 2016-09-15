










shinyApp(options = list(height = '550px'),
         
  ui = fluidPage(theme = shinythemes::shinytheme('flatly'),
                 try(includeCSS(system.file('css',
                                           'my-shiny.css', 
                                           package = 'teachingApps')), silent = T),
        mainPanel(width = 12, DT::dataTableOutput('amt')),
        
fixedPanel(htmlOutput('sign'),bottom = '1%', right = '1%', height = '30px')),

server = function(input, output, session) {

  output$sign <- renderUI({HTML(teachingApps::teachingApp(basename(getwd())))})
    
    output$amt <- DT::renderDataTable({
      
      DT::datatable(mtcars, 
                    options = list(pageLength = 8))
})
})
