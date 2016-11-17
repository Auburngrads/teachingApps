library(teachingApps)
library('metricsgraphics')

shinyApp(options = list(height = "700px"),
         onStart = function() { options('markdown.HTML.stylesheet' = system.file('css','my-shiny.css', package = 'teachingApps'))},
         
ui = navbarPage(collapsible = T, 
                position = 'fixed-top',
                title = 'Largest Extreme Value Distribution',
                theme = shinythemes::shinytheme(theme = source('args.R')[[1]]$theme),
                header = tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
                footer = HTML(teachingApps::teachingApp(source('args.R')[[1]]$appName)),
                
tabPanel(h4('Shiny App'),
sidebarLayout(
sidebarPanel(width = 3, 
  hr(),
  sliderInput("range.lev", 
              label = h2("Range"),
              min = -20, 
              max = 20, 
              value = c(-6,6)),
  hr(),
  sliderInput("mu.lev", 
              label = h2(HTML("Mean (&mu;)")),
              min = -3, 
              max = 3, 
              step = 0.5, 
              value = 0, 
              animate = T),
  hr(),
  sliderInput("sig.lev", 
              label = h2(HTML("Std Dev (&sigma;)")),
              min = 1, 
              max = 10, 
              step = 0.5, 
              value = 1, 
              animate = T)),

mainPanel(width = 9,
 tabsetPanel(type = 'pills',
  tabPanel(h4('Distribution Function'),  metricsgraphicsOutput('levC',height = "600px")),
  tabPanel(h4('Density'),                metricsgraphicsOutput('levP',height = "600px")),
  tabPanel(h4('Survival'),               metricsgraphicsOutput('levR',height = "600px")),
  tabPanel(h4('Hazard'),                 metricsgraphicsOutput('levh',height = "600px")),
  tabPanel(h4('Cumulative Hazard'),      metricsgraphicsOutput('levH',height = "600px")),
  tabPanel(h4('Quantile'),               metricsgraphicsOutput('levQ',height = "600px")))))),

tabPanel(h4('Distribution Functions'),
         mainPanel(uiOutput('levfunc'), class = 'shiny-text-output', width = 12)),

tabPanel(h4('Distribution Properties'),
         mainPanel(uiOutput('levprops', class = 'shiny-text-output'), width = 12))),

server = function(input, output, session) {
  
t = reactive({ signif(seq(min(input$range.lev), max(input$range.lev), length = 500), digits = 4)})
p <- signif(seq(0, 1, length = 500), digits = 4) 
C <- reactive({ plev(t(), input$mu.lev, input$sig.lev)})
P <- reactive({ dlev(t(), input$mu.lev, input$sig.lev)})
R <- reactive({ 1-C()})
h <- reactive({ exp(log(P())-log(R()))})
H <- reactive({ -1*log(1-plev(t(), input$mu.lev, input$sig.lev))})
Q <- reactive({ qlev(p, input$mu.lev, input$sig.lev)})
df <- reactive({data.frame(Time = t(),PROB = p, CDF = C(),PDF = P(),REL = R(),haz = h(),HAZ = H(), QUANT = Q())})

  output$levC <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'F(t)')%>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")}) 
  
  output$levP <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'f(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$levR <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'S(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$levh <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'h(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$levH <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'H(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$levQ <- renderMetricsgraphics({
  mjs_plot(df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Probability (p)', y_label = 't(p)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
output$levfunc <- renderUI({ 
  withMathJax(HTML(includeMarkdown('lev-func.Rmd')))
})
output$levprops <- renderUI({HTML(includeMarkdown('lev-props.Rmd'))
}) 
})
