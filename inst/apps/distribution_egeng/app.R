library(pos = -1,  package = 'SMRD')
library(pos = -1,  package = 'metricsgraphics')









  
shinyApp(options = list(width = "100%", height = "700px"),
ui = fluidPage(theme = shinythemes::shinytheme(theme = get('theme', envir = .jkf.apps)),
               try(includeCSS(system.file('css',
                                          'my-shiny.css',
                                          package = 'teachingApps')), silent = TRUE),
sidebarLayout(
sidebarPanel(width = 3,

  sliderInput("range.egeng", 
              label = h2("Range"),
              min =  0, 
              max = 50, 
              value = c(0,25)),
  sliderInput("mu.egeng", 
              label = h2(HTML("&mu;")),
              min = 0, 
              max = 10, 
              step = 0.5, 
              value = 1, 
              animate = TRUE),
  sliderInput("sig.egeng", 
              label = h2(HTML("&sigma;")),
              min = 0.5, 
              max = 10, 
              step = 0.5, 
              value = 1, 
              animate = TRUE),
  sliderInput("lam.egeng", 
              label = h2(HTML("&lambda;")),
              min = .5, 
              max = 10, 
              step = 0.5, 
              value = 1,
              animate = TRUE)),
  mainPanel(width = 9,
 tabsetPanel(type = 'pills',
  tabPanel(h4('Distribution Function'),metricsgraphicsOutput("egengC",height = "600px")),
  tabPanel(h4('Density'),              metricsgraphicsOutput("egengP",height = "600px")),
  tabPanel(h4('Survival'),             metricsgraphicsOutput("egengR",height = "600px")),
  tabPanel(h4('Hazard'),               metricsgraphicsOutput("egengh",height = "600px")),
  tabPanel(h4('Cumulative Hazard'),    metricsgraphicsOutput("egengH",height = "600px")),
  tabPanel(h4('Quantile'),             metricsgraphicsOutput("egengQ",height = "600px"))
  ))),

fixedPanel(htmlOutput('sign'),bottom = '1%', right = '1%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(basename(getwd())))})
  
t <- reactive({ signif(seq(input$range.egeng[1], input$range.egeng[2], length = 500), digits = 4)})
p <- signif(seq(0, 1, length = 500), digits = 4) 
C <- reactive({ pegengl(t(), input$mu.egeng, input$sig.egeng, input$lam.egeng)})
P <- reactive({ degengl(t(), input$mu.egeng, input$sig.egeng, input$lam.egeng)})
R <- reactive({ 1-C()})
h <- reactive({ exp(log(P())-log(R()))})
H <- reactive({ -1*log(1-pegengl(t(), input$mu.egeng, input$sig.egeng, input$lam.egeng))})
Q <- reactive({ qegengl(p, input$mu.egeng, input$sig.egeng, input$lam.egeng)})
df <- reactive({data.frame(Time = t(),PROB = p, CDF = C(),PDF = P(),REL = R(),haz = h(),HAZ = H(), QUANT = Q())})

  output$egengC <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'F(t)')%>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")}) 
  
  output$egengP <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'f(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$egengR <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'S(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$egengh <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'h(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$egengH <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'H(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$egengQ <- renderMetricsgraphics({
  mjs_plot(df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Probability (p)', y_label = 't(p)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
})
