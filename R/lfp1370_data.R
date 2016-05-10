lfp1370_data <-
function(...) {
  
  loadNamespace(shiny)
  
shinyApp(options = list(height = '800px', width = '99%'),
  ui = navbarPage(theme = shinythemes::shinytheme('flatly'),includeCSS('css/my-shiny.css'),
        tabPanel(h4('Data Set'), DT::dataTableOutput('lfp1370')),
        tabPanel(h4('Event Plot'),
            sidebarLayout(
            sidebarPanel(
            shinyAce::aceEditor('lfpeventplot', mode = 'r', theme = 'github', fontSize = 14,
                      value = "par(family = 'serif', font = 2, cex = 1.15)
loadNamespace(SMRD)
lfp.ld<- frame.to.ld(lfp1370,
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
            shinyAce::aceEditor('lfpcdfplot', mode = 'r', theme = 'github', fontSize = 14,
                      value = "par(family = 'serif', font = 2, cex = 1.15)
loadNamespace(SMRD)
lfp.ld<- frame.to.ld(lfp1370,
                     response.column = 1,
                     censor.column = 2,
                     case.weight.column=3,
                     data.title = 'Integrated Circuit Failure Data',
                     time.units = 'Hours')
plot(lfp.ld)"),
              actionButton('evallfpcdf', h4('Evaluate'))),

        mainPanel(plotOutput('plotlfpcdf', height = '600px'))))),

server = function(input, output, session) {
loadNamespace(SMRD)
  output$lfp1370 <- DT::renderDataTable({DT::datatable(lfp1370,
                                                       options = list(pageLength = 12))})

  output$plotlfpevent <- renderPlot({
      input$evallfpevent
      return(isolate(eval(parse(text=input$lfpeventplot))))
})

  output$plotlfpcdf <- renderPlot({
      input$evallfpcdf
      return(isolate(eval(parse(text=input$lfpcdfplot))))
})
})
}
