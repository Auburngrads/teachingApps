library(teachingApps)
library( package = 'metricsgraphics')










  


shinyApp(options = list(height = "700px"),
ui = fluidPage(theme = shinythemes::shinytheme(theme = source('www/args.R')[[1]]$theme), 
               try(includeCSS(system.file('css',
                                          'my-shiny.css', 
                                          package = 'teachingApps')), silent = TRUE),
sidebarLayout(
sidebarPanel(width = 3, 
  hr(),
  sliderInput("range.l", 
              label = h2("Range"),
              min = -20, 
              max = 20, 
              value = c(-4,4)),
  hr(),
  sliderInput("mu.l", 
              label = h2(HTML("Mean (&mu;)")),
              min = -3, 
              max = 3, 
              step = 0.5, 
              value = 0, 
              animate = T),
  hr(),
  sliderInput("sig.l", label = h2(HTML("Std Dev (&sigma;)")),
              min = 0.5, max = 5, step = 0.5, value = 1, animate = T)),

mainPanel(width = 9,
 tabsetPanel(type = 'pills',
  tabPanel(h4('Distribution Function'),  metricsgraphicsOutput("logC",height = "550px")),
  tabPanel(h4('Density'),                metricsgraphicsOutput("logP",height = "600px")),
  tabPanel(h4('Survival'),               metricsgraphicsOutput("logR",height = "600px")),
  tabPanel(h4('Hazard'),                 metricsgraphicsOutput("logh",height = "600px")),
  tabPanel(h4('Cumulative Hazard'),      metricsgraphicsOutput("logH",height = "600px")),
  tabPanel(h4('Quantile'),               metricsgraphicsOutput("logQ",height = "600px"))))),

fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(source('www/args.R')[[1]]$appName))})

t = reactive({ signif(seq(min(input$range.l), max(input$range.l), length = 500), digits = 4)})
p <- signif(seq(0, 1, length = 500), digits = 4) 
C <- reactive({ plogis(t(), input$mu.l, input$sig.l)})
P <- reactive({ dlogis(t(), input$mu.l, input$sig.l)})
R <- reactive({ 1-C()})
h <- reactive({ exp(log(P())-log(R()))})
H <- reactive({ -1*log(1-plogis(t(), input$mu.l, input$sig.l))})
Q <- reactive({ qlogis(p, input$mu.l, input$sig.l)})
df <- reactive({data.frame(Time = t(),PROB = p, CDF = C(),PDF = P(),REL = R(),haz = h(),HAZ = H(), QUANT = Q())})

  output$logC <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'F(t)')%>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")}) 
  
  output$logP <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'f(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$logR <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'S(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$logh <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'h(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$logH <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'H(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$logQ <- renderMetricsgraphics({
  mjs_plot(df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Probability (p)', y_label = 't(p)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
})
