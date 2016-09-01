teachingApps::getPackage('SMRD')
teachingApps::getPackage('metricsgraphics')
  
shinyApp(options = list(width = "100%", height = "700px"),
         
ui = fluidPage(theme = shinythemes::shinytheme("flatly"),
               try(includeCSS(system.file('css',
                                          'my-shiny.css',
                                          package = 'teachingApps')), silent = TRUE),
sidebarLayout(
sidebarPanel(width = 3,hr(),
  
  sliderInput("rangebisa", 
              label = h2("Range"),
              min = 0, 
              max = 20, 
              value = c(0,4)),
  hr(),
  sliderInput("be.bisa", 
              label = h2(HTML("Shape (&beta;)")),
              min = 0.5, 
              max = 10, 
              step = 0.5, 
              value = 1, 
              animate = TRUE),
  hr(),
  sliderInput("th.bisa", 
              label = h2(HTML("Scale (&theta;)")),
              min = 0.5, 
              max = 10, 
              step = 0.5, 
              value = 1,
              animate = TRUE)),

  mainPanel(width = 9,
 tabsetPanel(type = 'pills',
  tabPanel(h4('Distribution Function'),metricsgraphicsOutput("bisaC",height = "600px")),
  tabPanel(h4('Density'),              metricsgraphicsOutput("bisaP",height = "600px")),
  tabPanel(h4('Survival'),             metricsgraphicsOutput("bisaR",height = "600px")),
  tabPanel(h4('Hazard'),               metricsgraphicsOutput("bisah",height = "600px")),
  tabPanel(h4('Cumulative Hazard'),    metricsgraphicsOutput("bisaH",height = "600px")),
  tabPanel(h4('Quantile'),             metricsgraphicsOutput("bisaQ",height = "600px"))
  ))),

fixedPanel(htmlOutput('sign'),bottom = '1%', right = '1%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp('acceptance_mtbf'))})
  
 

t <-  reactive({ signif(seq(input$rangebisa[1], input$rangebisa[2],length = 500), digits = 4) })
p <-  reactive({ signif(seq(0, 1, length = 500), digits = 4)  })
C <-  reactive({ pbisa(t(), input$be.bisa,input$th.bisa) })
P <-  reactive({ dbisa(t(), input$be.bisa,input$th.bisa)})
R <-  reactive({ 1-C()})
h <-  reactive({exp(log(P())-log(R()))})
H <-  reactive({ -1*log(1-pbisa(t(), input$be.bisa,input$th.bisa))})
Q <-  reactive({ qbisa(p(), input$be.bisa,input$th.bisa)})
df <- reactive({data.frame(Time = t(),PROB = p(), CDF = C(),PDF = P(),REL = R(),haz = h(),HAZ = H(), QUANT = Q())})

  output$bisaC <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'F(t)')%>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")}) 
  
  output$bisaP <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'f(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$bisaR <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'S(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$bisah <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'h(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$bisaH <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'H(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$bisaQ <- renderMetricsgraphics({
  mjs_plot(df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Probability (p)', y_label = 't(p)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
})

