library( package = 'SMRD')










  


shinyApp(options = list(height = '800px', width = '99%'),
  ui = navbarPage(theme = shinythemes::shinytheme(theme = source('www/args.R')[[1]]$theme), 
                  try(includeCSS(system.file('css',
                                           'my-shiny.css', 
                                           package = 'teachingApps')), silent = TRUE),
                  
        tabPanel(h4('Data Set'), DT::dataTableOutput('lfp1370')),
        tabPanel(h4('Event Plot'),
            sidebarLayout(
            sidebarPanel(
            shinyAce::aceEditor(fontSize = 16, 
                                     wordWrap = T,
                                     outputId = 'lfpeventplot', 
                                mode = 'r', 
                                theme = 'github', 
                                
                                value = 
"par(family = 'serif', font = 2, cex = 1.15)

library( package = SMRD)

lfp.ld<- frame.to.ld(SMRD::lfp1370,
                     response.column = 1,
                     censor.column = 2,
                     case.weight.column=3,
                     data.title = 'Integrated Circuit Failure Data',
                     time.units = 'Hours')
event.plot(lfp.ld)"),

        actionButton('evallfpevent', h4('Evaluate'))),

        mainPanel(plotOutput('plotlfpevent', height = '600px')))),

        tabPanel(h4('CDF Plot'),
            sidebarLayout(
            sidebarPanel(
            shinyAce::aceEditor(fontSize = 16, 
                                     wordWrap = T,
                                     outputId = 'lfpcdfplot', 
                                mode = 'r', 
                                theme = 'github', 
                                
                                value = 
"par(family = 'serif', font = 2, cex = 1.15)

library( package = SMRD)
lfp.ld<- frame.to.ld(SMRD::lfp1370,
                     response.column = 1,
                     censor.column = 2,
                     case.weight.column=3,
                     data.title = 'Integrated Circuit Failure Data',
                     time.units = 'Hours')
plot(lfp.ld)"),

        actionButton('evallfpcdf', h4('Evaluate'), width = '100%')),

        mainPanel(plotOutput('plotlfpcdf', height = '600px')))),

fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(source('www/args.R')[[1]]$appName))})
  


  output$lfp1370 <- DT::renderDataTable({DT::datatable(SMRD::lfp1370,
                                                       options = list(pageLength = 10))})

  output$plotlfpevent <- renderPlot({
      input$evallfpevent
      return(isolate(eval(parse(text=input$lfpeventplot))))
})

  output$plotlfpcdf <- renderPlot({
      input$evallfpcdf
      return(isolate(eval(parse(text=input$lfpcdfplot))))
})
})
