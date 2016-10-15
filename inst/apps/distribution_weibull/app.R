library( package = 'metricsgraphics')










  
get('arg2', envir = .GlobalEnv, inherits = T)

shinyApp(options = list(height = "700px"),
ui = fluidPage(theme = shinythemes::shinytheme(theme = arg2$theme), 
               try(includeCSS(system.file('css',
                                          'my-shiny.css', 
                                          package = 'teachingApps')), silent = TRUE),
sidebarLayout(
sidebarPanel(width = 3, 
  hr(),
  sliderInput("range.w", 
              label = h2("Range"),  
              min = 0, 
              max = 50, 
              value = c(0,25)),
  hr(),
  sliderInput("scale.w", 
              label = h2(HTML("Scale (&eta;)")),  
              min = 5, 
              max = 30, 
              step = 1, 
              value = 10, 
              animate = T),
  hr(),
  sliderInput("shape.w", 
              label = h2(HTML("Shape (&beta;)")),  
              min = .5, 
              max = 10, 
              step = .5, 
              value = .5, 
              animate = T)),

mainPanel(width = 9,
 tabsetPanel(type = 'pills',
  tabPanel(h4('Distribution Function'),  metricsgraphicsOutput("weibC",height = "600px")),
  tabPanel(h4('Density'),                metricsgraphicsOutput("weibP",height = "600px")),
  tabPanel(h4('Survival'),               metricsgraphicsOutput("weibR",height = "600px")),
  tabPanel(h4('Hazard'),                 metricsgraphicsOutput("weibh",height = "600px")),
  tabPanel(h4('Cumulative Hazard'),      metricsgraphicsOutput("weibH",height = "600px")),
  tabPanel(h4('Quantile'),               metricsgraphicsOutput("weibQ",height = "600px"))))),

fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(arg2$appName))})

weibhaz <-function(x,sc, sh) {sh/sc*(x/sc)^(sh-1)}
  
t = reactive({ signif(seq(min(input$range.w), max(input$range.w), length = 500), digits = 4)})
p <- signif(seq(0, 1, length = 500), digits = 4) 
C <- reactive({ pweibull(t(), input$shape.w, input$scale.w)})
P <- reactive({ dweibull(t(), input$shape.w, input$scale.w)})
R <- reactive({ 1-C()})
h <- reactive({ weibhaz(t(), input$scale.w, input$shape.w)})
H <- reactive({ -1*log(1-pweibull(t(), input$shape.w, input$scale.w))})
Q <- reactive({ qweibull(p, input$shape.w, input$scale.w)})
df <- reactive({data.frame(Time = t(),PROB = p, CDF = C(),PDF = P(),REL = R(),haz = h(),HAZ = H(), QUANT = Q())})

  output$weibC <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'F(t)')%>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")}) 
  
  output$weibP <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'f(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$weibR <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'S(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$weibh <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'h(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$weibH <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'H(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$weibQ <- renderMetricsgraphics({
  mjs_plot(df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Probability (p)', y_label = 't(p)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
})
