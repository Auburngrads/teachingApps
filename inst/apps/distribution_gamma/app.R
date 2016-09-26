library(pos = -1,  package = 'metricsgraphics')










  
load('args.Rdata')
shinyApp(options = list(width = "100%", height = "700px"),
         
ui = fluidPage(theme = shinythemes::shinytheme(theme = arg2$theme),
                try(includeCSS(system.file('css',
                                           'my-shiny.css',                                    
                                           package = 'teachingApps')), silent = TRUE),
sidebarLayout(
sidebarPanel(width = 3, hr(),
  sliderInput("range.gamma", 
              label = h2("Range"),
              min =  0, 
              max = 50, 
              value = c(0,25)), hr(),
  sliderInput("theta", 
              label = h2(HTML("Scale Parameter &theta;")),
              min = .25, 
              max = 4, 
              step = .25, 
              value = .5, 
              animate = TRUE), hr(),
  sliderInput("kappa",
              label = h2(HTML("Shape Parameter &kappa;")),
              min = .25, 
              max = 15, 
              step = .25, 
              value = 1,
              animate = TRUE)),
mainPanel(width = 9,
 tabsetPanel(type = 'pills',
  tabPanel(h4('Distribution Function'),metricsgraphicsOutput("gammaC",height = "600px")),
  tabPanel(h4('Density'),              metricsgraphicsOutput("gammaP",height = "600px")),
  tabPanel(h4('Survival'),             metricsgraphicsOutput("gammaR",height = "600px")),
  tabPanel(h4('Hazard'),               metricsgraphicsOutput("gammah",height = "600px")),
  tabPanel(h4('Cumulative Hazard'),    metricsgraphicsOutput("gammaH",height = "600px")),
  tabPanel(h4('Quantile'),             metricsgraphicsOutput("gammaQ",height = "600px")) ))),

fixedPanel(htmlOutput('sign'),bottom = '9%', right = '40%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(basename(getwd())))})

t = reactive({ signif(seq(min(input$range.gamma), max(input$range.gamma), length = 500), digits = 4)})
p <- signif(seq(0, 1, length = 500), digits = 4)
C <- reactive({ pgamma(t(), input$kappa, input$theta)})
P <- reactive({ dgamma(t(), input$kappa, input$theta)})
R <- reactive({ 1-C()})
h <- reactive({ exp(log(P())-log(R()))})
H <- reactive({ -1*log(1-pgamma(t(), input$kappa, input$theta))})
Q <- reactive({ qgamma(p, input$kappa, input$theta)})
df <- reactive({data.frame(Time = t(),PROB = p, CDF = C(),PDF = P(),REL = R(),haz = h(),HAZ = H(), QUANT = Q())})

  output$gammaC <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'F(t)')%>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")}) 
  
  output$gammaP <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'f(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$gammaR <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'S(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$gammah <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'h(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$gammaH <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'H(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$gammaQ <- renderMetricsgraphics({
  mjs_plot(df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Probability', y_label = 'q(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
})
