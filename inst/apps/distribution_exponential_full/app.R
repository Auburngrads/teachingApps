library(teachingApps)
library('metricsgraphics')

shinyApp(options = list(height = "800px"),
         onStart = function() { options('markdown.HTML.stylesheet' = system.file('css','my-shiny.css', package = 'teachingApps'))},
         
ui = navbarPage(collapsible = T, 
                position = 'fixed-top',
                title = 'Exponential Distribution',
                theme = shinythemes::shinytheme(theme = global$theme),
                header = tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
                footer = HTML(teachingApps::teachingApp(global$appName)),

tabPanel(h4('Shiny App'),
sidebarLayout(
sidebarPanel(width = 3, 
  sliderInput("rangee", 
              label = h2("Range:"),
              min = 0, 
              max = 50, 
              value = c(0,20)),
  sliderInput("theta", 
              label = h2(HTML("Scale (&theta;)")),
              min = .5, 
              max = 10, 
              step = .5, 
              value = 1), 
  sliderInput("gamma", 
              label = h2(HTML("Location (&gamma;)")),
              min = 0, 
              max = 15, 
              step = 1, 
              value = 0),
  withMathJax(),
  actionButton('ecdf', HTML('<script type="math/tex">F(t)</script>'),width = '31%'),
  actionButton('epdf', HTML('<script type="math/tex">f(t)</script>'),width = '31%'),
  actionButton('esur', HTML('<script type="math/tex">S(t)</script>'),width = '31%'),
  hr(),
  actionButton('ehaz', HTML('<script type="math/tex">h(t)</script>'),width = '31%'),
  actionButton('eHAZ', HTML('<script type="math/tex">H(t)</script>'),width = '31%'),
  actionButton('equa', HTML('<script type="math/tex">t(p)</script>'),width = '31%')),

  mainPanel(width = 9,  metricsgraphicsOutput("expfuncs",height = "600px")))),

tabPanel(h4('Distribution Functions'),
         mainPanel(uiOutput('expfunc'), class = 'shiny-text-output', width = 12)),

tabPanel(h4('Distribution Properties'),
         mainPanel(uiOutput('expprops', class = 'shiny-text-output'), width = 12))),

server = function(input, output, session) {
  
t = reactive({ signif(seq(min(input$rangee), max(input$rangee), length = 500), digits = 4)})
p <- signif(seq(0, 1, length = 500), digits = 4) 
C <- reactive({ pexp(t() - input$gamma, 1/input$theta)})
P <- reactive({ dexp(t() - input$gamma, 1/input$theta)})
R <- reactive({ 1-C()})
h <- reactive({ 1/input$theta })
H <- reactive({ -1*log(1-pexp(t() - input$gamma, 1/input$theta))})
Q <- reactive({ input$gamma-log(1-p)*input$theta})
df <- reactive({data.frame(Time = t(),PROB = p, CDF = C(),PDF = P(),REL = R(),haz = h(),HAZ = H(), QUANT = Q())})

observeEvent(input$ecdf, {  
  output$expfuncs <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'F(t)')%>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
})
observeEvent(input$epdf, {  
  output$expfuncs <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'f(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
})
observeEvent(input$esur, {  
  output$expfuncs <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'S(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
})
observeEvent(input$ehaz, {  
  output$expfuncs <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'h(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
})
observeEvent(input$eHAZ, {  
  output$expfuncs <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'H(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
})
observeEvent(input$equa, {  
  output$expfuncs <- renderMetricsgraphics({
  mjs_plot(df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Probability (p)', y_label = 't(p)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
})

output$expfunc <- renderUI({ 
  withMathJax(HTML(includeMarkdown('exp-func.Rmd')))
})
output$expprops <- renderUI({HTML(includeMarkdown('exp-props.Rmd'))
})
})
