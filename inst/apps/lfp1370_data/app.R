library(teachingApps)
library('SMRD')

shinyApp(options = list(height = "800px"),
         onStart = function() { options('markdown.HTML.stylesheet' = system.file('css','my-shiny.css', package = 'teachingApps'))},
         
  ui = navbarPage(collapsible = T, 
                position = 'fixed-top',
                title = 'lfp1370 Example',
                theme = shinythemes::shinytheme(theme = source('args.R')[[1]]$theme),
                header = tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
                footer = HTML(teachingApps::teachingApp(source('args.R')[[1]]$appName)),
                  
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

library(SMRD)

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

library(SMRD)
lfp.ld<- frame.to.ld(SMRD::lfp1370,
                     response.column = 1,
                     censor.column = 2,
                     case.weight.column=3,
                     data.title = 'Integrated Circuit Failure Data',
                     time.units = 'Hours')
plot(lfp.ld)"),

        actionButton('evallfpcdf', h4('Evaluate'), width = '100%')),

        mainPanel(plotOutput('plotlfpcdf', height = '600px'))))),

server = function(input, output, session) {
  
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
