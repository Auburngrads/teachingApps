distribution_goma <-
function(...) {
  
  try(attachNamespace('shiny'), silent = TRUE)
  try(attachNamespace('SMRD'), silent = TRUE)
  try(attachNamespace('metricsgraphics'), silent = TRUE)
  
shinyApp(options = list(height = "700px"),
ui = fluidPage(theme = shinythemes::shinytheme("flatly"),
               try(includeCSS(system.file('css',
                                          'my-shiny.css',
                                          package = 'teachingApps')), silent = TRUE),
sidebarLayout(
sidebarPanel(width = 3,
  
  sliderInput("rangegoma", 
              label = h2("Range"),
              min = 0, 
              max = 50, 
              value = c(0,20)),
  sliderInput("th.goma", 
              label = h2(HTML("Scale (&theta;)")),
              min = 0.5, 
              max = 10, 
              step = 0.5, 
              value = 1, 
              animate = TRUE),
  sliderInput("ze.goma", 
              label = h2(HTML("Shape 1 (&zeta;)")),
              min = 0.5, 
              max = 10, 
              step = 0.5, 
              value = 1, 
              animate = TRUE),
  sliderInput("et.goma", 
              label = h2(HTML("Shape 2 (&eta;)")),
              min = 0.5, 
              max = 10, 
              step = 0.5, 
              value = 1,
              animate = TRUE)),

  mainPanel(width = 9,
 tabsetPanel(type = 'pills',
  tabPanel(h4('Distribution Function'),metricsgraphicsOutput("gomaC",height = "600px")),
  tabPanel(h4('Density'),              metricsgraphicsOutput("gomaP",height = "600px")),
  tabPanel(h4('Survival'),             metricsgraphicsOutput("gomaR",height = "600px")),
  tabPanel(h4('Hazard'),               metricsgraphicsOutput("gomah",height = "600px")),
  tabPanel(h4('Cumulative Hazard'),    metricsgraphicsOutput("gomaH",height = "600px")),
  tabPanel(h4('Quantile'),             metricsgraphicsOutput("gomaQ",height = "600px"))
  ))),

fixedPanel(htmlOutput('sign'),bottom = '1%', right = '1%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApp('acceptance_mtbf'))})
  
 
  
t <-  reactive({ signif(seq(input$rangegoma[1], input$rangegoma[2],length = 500),digits = 4)})
p <-  reactive({ signif(seq(0.001, .999, length = 500), digits = 4) })
C <-  reactive({ pgoma(t(), input$th.goma, input$ze.goma, input$et.goma)})
P <-  reactive({ dgoma(t(), input$th.goma, input$ze.goma, input$et.goma)})
R <-  reactive({ 1-C()})
h <-  reactive({ exp(log(P())-log(R()))})
H <-  reactive({-1*log(1-pgoma(t(), input$th.goma,input$ze.goma,input$et.goma))})
Q <-  reactive({ qgoma(p(), input$th.goma,input$ze.goma,input$et.goma)})
df <- reactive({data.frame(Time = t(),PROB = p(), CDF = C(),PDF = P(),REL = R(),haz = h(),HAZ = H(), QUANT = Q())})

  output$gomaC <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'F(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")}) 
  
  output$gomaP <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'f(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$gomaR <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'S(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$gomah <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'h(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$gomaH <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'H(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$gomaQ <- renderMetricsgraphics({
  mjs_plot(df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Probability (p)', y_label = 't(p)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
})
}
