library(teachingApps)
library('SMRD')
library('metricsgraphics')









  


shinyApp(options = list(height = "700px"),
         onStart = function() { options('markdown.HTML.stylesheet' = system.file('css','my-shiny.css', package = 'teachingApps'))},
ui = fluidPage(theme = shinythemes::shinytheme(theme = source('args.R')[[1]]$theme),
                tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
sidebarLayout(
sidebarPanel(width = 3,

  sliderInput("range.geng", 
              label = h2("Range"),
              min =  0, 
              max = 50, 
              value = c(0,25)),
  sliderInput("theta.geng", 
              label = h2(HTML("&theta;")),
              min = 0.5, 
              max = 10, 
              step = 0.5, 
              value = 1,
              animate = TRUE),
  sliderInput("beta.geng", 
              label = h2(HTML("&beta;")),
              min = 0.5, 
              max = 10, 
              step = 0.5, 
              value = 1, 
              animate = TRUE),
  sliderInput("kappa.geng",
              label = h2(HTML("&kappa;")),
              min = 0.5, 
              max = 10, 
              step = 0.5, 
              value = 1,
              animate = TRUE)),
  mainPanel(width = 9,
 tabsetPanel(type = 'pills',
  tabPanel(h4('Distribution Function'),metricsgraphicsOutput("gengC",height = "600px")),
  tabPanel(h4('Density'),              metricsgraphicsOutput("gengP",height = "600px")),
  tabPanel(h4('Survival'),             metricsgraphicsOutput("gengR",height = "600px")),
  tabPanel(h4('Hazard'),               metricsgraphicsOutput("gengh",height = "600px")),
  tabPanel(h4('Cumulative Hazard'),    metricsgraphicsOutput("gengH",height = "600px")),
  tabPanel(h4('Quantile'),             metricsgraphicsOutput("gengQ",height = "600px"))
  ))),

fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(source('args.R')[[1]]$appName))})
  

  
t <- reactive({ signif(seq(min(input$range.geng), max(input$range.geng), length = 500), digits = 4)})
p <- signif(seq(0, 1, length = 500), digits = 4) 
C <- reactive({ pgeng(t(), input$theta.geng, input$beta.geng, input$kappa.geng)})
P <- reactive({ dgeng(t(), input$theta.geng, input$beta.geng, input$kappa.geng)})
R <- reactive({ 1-C()})
h <- reactive({ exp(log(P())-log(R()))})
H <- reactive({ -1*log(1-pgeng(t(), input$theta.geng, input$beta.geng, input$kappa.geng))})
Q <- reactive({ qgeng(p, input$theta.geng, input$beta.geng, input$kappa.geng)})
df <- reactive({data.frame(Time = t(),PROB = p, CDF = C(),PDF = P(),REL = R(),haz = h(),HAZ = H(), QUANT = Q())})

  output$gengC <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'F(t)')%>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")}) 
  
  output$gengP <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'f(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$gengR <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'S(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$gengh <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'h(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$gengH <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'H(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$gengQ <- renderMetricsgraphics({
  mjs_plot(df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Probability', y_label = 'q(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
})
