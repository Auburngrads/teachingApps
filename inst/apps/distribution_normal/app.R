library(pos = -1,  package = 'metricsgraphics')










  
shinyApp(options = list(height = "700px"),
         
ui = fluidPage(theme = shinythemes::shinytheme("flatly"),
              try(includeCSS(system.file('css',
                                          'my-shiny.css', 
                                          package = 'teachingApps')), silent = TRUE),
sidebarLayout(
sidebarPanel(width = 3, 
  hr(),
  sliderInput("range.n", 
              label = h2("Range"),
              min = -20, 
              max = 20, 
              value = c(-4,4)),
  hr(),
  sliderInput("mu.n", 
              label = h2(HTML("Mean (&mu;)")),
              min = -3, 
              max = 3, 
              step = 0.5, 
              value = 0, 
              animate = T),
  hr(),
  sliderInput("sig.n", 
              label = h2(HTML("Std Dev (&sigma;)")),
              min = 0.5, 
              max = 5, 
              step = 0.5, 
              value = 1, 
              animate = T)),

mainPanel(width = 9,
 tabsetPanel(type = 'pills',
  tabPanel(h4('Distribution Function'),metricsgraphicsOutput("norC",height = "600px")),
  tabPanel(h4('Density'),              metricsgraphicsOutput("norP",height = "600px")),
  tabPanel(h4('Survival'),             metricsgraphicsOutput("norR",height = "600px")),
  tabPanel(h4('Hazard'),               metricsgraphicsOutput("norh",height = "600px")),
  tabPanel(h4('Cumulative Hazard'),    metricsgraphicsOutput("norH",height = "600px")),
  tabPanel(h4('Quantile'),             metricsgraphicsOutput("norQ",height = "600px"))))),

fixedPanel(htmlOutput('sign'),bottom = '1%', right = '1%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(basename(getwd())))})
  


t <- reactive({ signif(seq(min(input$range.n), max(input$range.n), length = 500), digits = 4)})
p <- signif(seq(0, 1, length = 500), digits = 4) 
C <- reactive({ pnorm(t(), input$mu.n, input$sig.n)})
P <- reactive({ dnorm(t(), input$mu.n, input$sig.n)})
R <- reactive({ 1-C()})
h <- reactive({ exp(log(P())-log(R()))})
H <- reactive({ -1*log(1-pnorm(t(), input$mu.n, input$sig.n))})
Q <- reactive({ qnorm(p, input$mu.n, input$sig.n)})
df <- reactive({data.frame(Time = t(),PROB = p, CDF = C(),PDF = P(),REL = R(),haz = h(),HAZ = H(), QUANT = Q())})

  output$norC <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'F(t)')%>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")}) 
  
  output$norP <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'f(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$norR <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'S(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$norh <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'h(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$norH <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'H(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$norQ <- renderMetricsgraphics({
  mjs_plot(df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Probability', y_label = 'q(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
})
