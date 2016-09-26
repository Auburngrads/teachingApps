library(pos = -1,  package = 'SMRD')











load('args.Rdata')
shinyApp(options = list(height = '600px'),
         
ui = fluidPage(theme = shinythemes::shinytheme(theme = arg2$theme),
               try(includeCSS(system.file('css',
                                           'my-shiny.css', 
                                           package = 'teachingApps')), silent = TRUE),
             
     sidebarLayout(
     sidebarPanel(width = 3,
     selectInput("n7.3", 
                 label = h2("Observations:"),
                 choices = c("20", "200", "2000", "10220"), 
                 selected = "20")),
     
     mainPanel(plotOutput('berksonmle', height = '600px'), width = 9)),

fixedPanel(htmlOutput('sign'),bottom = '9%', right = '40%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(basename(getwd())))})
  
  output$berksonmle <- renderPlot({
    
par(family="serif",font=2)

berkson <- switch(input$n7.3, 
                  "20" = {SMRD::berkson20},
                  "200" = {SMRD::berkson200},
                  "2000" = {SMRD::berkson2000},
                  "10220" = {SMRD::berkson10220})

berkson.ld <- frame.to.ld(berkson,
                          response.column = c(1,2),
                          censor.column = 3,
                          case.weight.column = 4)

mleprobplot(berkson.ld, distribution = "Exponential")  
})
})
