library( package = 'plotly')











get('arg2', envir = .GlobalEnv, inherits = T)

shinyApp(options = list(height = '800px', width = '100%'),
         
    ui = navbarPage(theme = shinythemes::shinytheme(theme = arg2$theme), 
                    try(includeCSS(system.file('css',
                                               'my-shiny.css', 
                                               package = 'teachingApps')), silent = T),
          
tabPanel(h4('Test For Proportions'),
         sidebarLayout(
           sidebarPanel(width = 3,
             sliderInput('sss', h4('Sample Size'), 
                          min = 5, 
                          max = 30, 
                          step = 1, 
                          value = 10),
             sliderInput('fails2', h4('Failures Allowed'), 
                          min = 0, 
                          max = 10, 
                          step = 1, 
                          value = 1),
             sliderInput('thresh2', h4('Threshold Proportion'), 
                          min = .05, 
                          max = 1, 
                          step = .05, 
                          value = .1),
             sliderInput('objective2', h4('Objective Proportion'), 
                          min = .15, 
                          max = 1, 
                          step = .05, 
                          value = .3),
             sliderInput('contract2', h4('Contract Proportion'), 
                          min = .25, 
                          max = 1, 
                          step = .05, 
                          value = .5)),
           mainPanel(plotlyOutput('prop', height = '650px'),width = 9))),

fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px')),

server = function(input, output, session) {
  
  library( package = 'plotly')
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(arg2$appName))})
  
  output$prop <- renderPlotly({

props <- seq(0,1,.01)
accept2 <- pbinom(input$fails2, input$sss, props)
datas2 <- data.frame(props, accept2) 

observe({

if(input$thresh2>=input$objective2) { 

   updateSliderInput(session, "objective2", value = input$thresh2+.1) } 

if(input$objective2>=input$contract2) { 

   updateSliderInput(session, "contract2", value = input$objective2+.1) }
  
})

p1 <- plot_ly(datas2, x = props, y = accept2, showlegend = T, name = 'Pr(accept)')
p2 <- add_trace(p1, 
                x = rep(input$thresh2,2), 
                y = c(0,pbinom(input$fails2, input$sss,input$thresh2)),
                showlegend = T,
                name = 'Threshold',
                hoverinfo = 'text')
p3 <- add_trace(p2, 
                x = rep(input$objective2,2), 
                y = c(0,pbinom(input$fails2, input$sss, input$objective2)),
                showlegend = T,
                name = 'Objective',
                hoverinfo = 'text')
p4 <- add_trace(p3, 
                x = rep(input$contract2,2), 
                y = c(0,pbinom(input$fails2, input$sss, input$contract2)),
                showlegend = T,
                name = 'Contract',
                hoverinfo = 'text')
p5 <- layout(p4, 
             yaxis = list(title = "Probability of Acceptance"), 
             xaxis = list(title = 'Proportion Conforming'),
             
             annotations = list(
               list(x = c(input$thresh2),
                    y = pbinom(input$fails2, input$sss, input$thresh2),
                    text = 'Threshold ',
                    showarrow = T,
                    ay = -40,
                    ax =  40),
               list(x = input$objective2,
                    y = pbinom(input$fails2, input$sss, input$objective2),
                    text = "Objective",
                    showarrow = T,
                    ay = -60,
                    ax =  50),
               list(x = input$contract2,
                    y = pbinom(input$fails2, input$sss, input$contract2),
                    text = "Contract",
                    showarrow = T,
                    ay = -80,
                    ax =  60)),
             font = list(size = 16))
})
})
