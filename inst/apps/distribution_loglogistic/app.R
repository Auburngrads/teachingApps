library(pos = -1,  package = 'metricsgraphics')
library(pos = -1,  package = 'actuar')









  
load('args.Rdata')
shinyApp(options = list(height = "700px"),
ui = fluidPage(theme = shinythemes::shinytheme(theme = arg2$theme), 
               try(includeCSS(system.file('css',
                                          'my-shiny.css', 
                                          package = 'teachingApps')), silent = TRUE),
sidebarLayout(
sidebarPanel(width = 3, 
  hr(),
  sliderInput("range.ll", 
              label = h2("Range"),
              min = 0, 
              max = 50, 
              value = c(0,20)),
  hr(),
  sliderInput("mu.ll", 
              label = h2(HTML("Mean (&mu;)")),
              min = 0.5, 
              max = 10, 
              step = 0.5, 
              value = 0.5, 
              animate = T),
  hr(),
  sliderInput("sig.ll", 
              label = h2(HTML("Std Dev (&sigma;)")),
              min = 0.5, 
              max = 10, 
              step = 0.5, 
              value = 1, 
              animate = T)),

mainPanel(width = 9,
 tabsetPanel(type = 'pills',
  tabPanel(h4('Distribution Function'),  metricsgraphicsOutput("llogC",height = "600px")),
  tabPanel(h4('Density'),                metricsgraphicsOutput("llogP",height = "600px")),
  tabPanel(h4('Survival'),               metricsgraphicsOutput("llogR",height = "600px")),
  tabPanel(h4('Hazard'),                 metricsgraphicsOutput("llogh",height = "600px")),
  tabPanel(h4('Cumulative Hazard'),      metricsgraphicsOutput("llogH",height = "600px")),
  tabPanel(h4('Quantile'),               metricsgraphicsOutput("llogQ",height = "600px"))))),

fixedPanel(htmlOutput('sign'),bottom = '9%', right = '40%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(basename(getwd())))})
  


t = reactive({ signif(seq(min(input$range.ll), max(input$range.ll), length = 500), digits = 4)})
p <- signif(seq(0, 1, length = 500), digits = 4) 
C <- reactive({ pllogis(t(), input$mu.ll, input$sig.ll)})
P <- reactive({ dllogis(t(), input$mu.ll, input$sig.ll)})
R <- reactive({ 1-C()})
h <- reactive({ exp(log(P())-log(R()))})
H <- reactive({ -1*log(1-pllogis(t(), input$mu.ll, input$sig.ll))})
Q <- reactive({ qllogis(p, input$mu.ll, input$sig.ll)})
df <- reactive({data.frame(Time = t(),PROB = p, CDF = C(),PDF = P(),REL = R(),haz = h(),HAZ = H(), QUANT = Q())})

  output$llogC <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'F(t)')%>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")}) 
  
  output$llogP <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'f(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$llogR <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'S(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$llogh <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'h(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$llogH <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'H(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$llogQ <- renderMetricsgraphics({
  mjs_plot(df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Probability (p)', y_label = 't(p)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
})
