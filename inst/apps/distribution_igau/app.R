library( package = 'SMRD')
library( package = 'metricsgraphics')









  


shinyApp(options = list(height = "700px"),
         
ui = fluidPage(theme = shinythemes::shinytheme(theme = source('www/args.R')[[1]]$theme),
               try(includeCSS(system.file('css',
                                          'my-shiny.css',
                                          package = 'teachingApps')), silent = TRUE),
sidebarLayout(
sidebarPanel(width = 3, hr(),
  
  sliderInput("rangeigau", 
              label = h2("Range"),
              min =  0, 
              max = 50, 
              value = c(0,25)),
  hr(),
  sliderInput("th.igau", 
              label = h2(HTML("Scale (&theta;)")),
              min = .5, 
              max = 10, 
              step = .5, 
              value = 1, 
              animate = TRUE),
  hr(),
  sliderInput("be.igau", 
              label = h2(HTML("Shape (&beta;)")),
              min = .5, 
              max = 10, 
              step = .5, 
              value = 1,
              animate = TRUE)),

mainPanel(width = 9,
 tabsetPanel(type = 'pills',
  tabPanel(h4('Distribution Function'),metricsgraphicsOutput("igauC",height = "600px")),
  tabPanel(h4('Density'),              metricsgraphicsOutput("igauP",height = "600px")),
  tabPanel(h4('Survival'),             metricsgraphicsOutput("igauR",height = "600px")),
  tabPanel(h4('Hazard'),               metricsgraphicsOutput("igauh",height = "600px")),
  tabPanel(h4('Cumulative Hazard'),    metricsgraphicsOutput("igauH",height = "600px")),
  tabPanel(h4('Quantile'),             metricsgraphicsOutput("igauQ",height = "600px"))
  ))),

fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(source('www/args.R')[[1]]$appName))})
  
t <-  reactive({ signif(seq(input$rangeigau[1], input$rangeigau[2], length = 500), digits = 4) })
p <-  reactive({ signif(seq(0.001, .999, length = 500), digits = 4) })
C <-  reactive({ pigau(t(), input$be.igau,input$th.igau)})
P <-  reactive({ digau(t(), input$be.igau,input$th.igau)})
R <-  reactive({ 1-C()})
h <-  reactive({ exp(log(P())-log(R()))})
H <-  reactive({ -1*log(1-pigau(t(), input$be.igau,input$th.igau))})
Q <-  reactive({ qigau(p(), input$be.igau,input$th.igau) })
df <- reactive({ data.frame(Time = t(),PROB = p(), CDF = C(),PDF = P(),REL = R(),haz = h(),HAZ = H(), QUANT = Q()) })

  output$igauC <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'F(t)')%>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")}) 
  
  output$igauP <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'f(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$igauR <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'S(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$igauh <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'h(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$igauH <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'H(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$igauQ <- renderMetricsgraphics({
  mjs_plot(df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Probability (p)', y_label = 't(p)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
})
