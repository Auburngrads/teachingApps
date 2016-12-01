library(teachingApps)
library('metricsgraphics')
library('SMRD')









  


shinyApp(options = list(height = "700px"),
         onStart = function() { options('markdown.HTML.stylesheet' = system.file('css','my-shiny.css', package = 'teachingApps'))},
ui = fluidPage(theme = shinythemes::shinytheme(theme = global$theme),
                tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
sidebarLayout(
sidebarPanel(width = 3, 
  hr(),
  sliderInput("range.s", 
              label = h2("Range"),
              min = -20, 
              max = 20, 
              value = c(-6,6)),
  hr(),
  sliderInput("mu.sev", 
              label = h2(HTML("Mean (&mu;)")),
              min = -3, 
              max = 3, 
              step = 0.5, 
              value = 0, 
              animate = T),
  hr(),
  sliderInput("sig.sev", 
              label = h2(HTML("Std Dev (&sigma;)")),
              min = 1, 
              max = 10, 
              step = 0.5, 
              value = 1, 
              animate = T)),

mainPanel(width = 9,
 tabsetPanel(type = 'pills',
  tabPanel(h4('Distribution Function'),  metricsgraphicsOutput("sevC",height = "600px")),
  tabPanel(h4('Density'),                metricsgraphicsOutput("sevP",height = "600px")),
  tabPanel(h4('Survival'),               metricsgraphicsOutput("sevR",height = "600px")),
  tabPanel(h4('Hazard'),                 metricsgraphicsOutput("sevh",height = "600px")),
  tabPanel(h4('Cumulative Hazard'),      metricsgraphicsOutput("sevH",height = "600px")),
  tabPanel(h4('Quantile'),               metricsgraphicsOutput("sevQ",height = "600px"))))),

fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(global$appName))})
  
t = reactive({ signif(seq(min(input$range.s), max(input$range.s), length = 500), digits = 4)})
p <- signif(seq(0, 1, length = 500), digits = 4) 
C <- reactive({ psev(t(), input$mu.sev, input$sig.sev)})
P <- reactive({ dsev(t(), input$mu.sev, input$sig.sev)})
R <- reactive({ 1-C()})
h <- reactive({ exp(log(P())-log(R()))})
H <- reactive({ -1*log(1-psev(t(), input$mu.sev, input$sig.sev))})
Q <- reactive({ qsev(p, input$mu.sev, input$sig.sev)})
df <- reactive({data.frame(Time = t(),PROB = p, CDF = C(),PDF = P(),REL = R(),haz = h(),HAZ = H(), QUANT = Q())})

  output$sevC <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'F(t)')%>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")}) 
  
  output$sevP <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'f(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$sevR <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'S(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$sevh <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'h(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$sevH <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'H(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$sevQ <- renderMetricsgraphics({
  mjs_plot(df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Probability (p)', y_label = 't(p)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
})
