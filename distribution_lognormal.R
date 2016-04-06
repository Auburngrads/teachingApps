distribution_lognormal <-
function(...) {

  library(shiny)
  library(metricsgraphics
          )
shinyApp(options = list(height = "700px"),
ui = fluidPage(theme = shinythemes::shinytheme("flatly"),
               includeCSS("css/my-shiny.css"),
sidebarLayout(
sidebarPanel(width = 3,hr(),
  
  sliderInput("range.ln", label = h2("Range:"),
              min = 0, max = 50, value = c(0,20)),
  hr(),
  sliderInput("mu.ln", label = h2(HTML("Log[Mean] (ln[&mu;])")),
              min = 0, max = 10, step = 0.5, value = 4, animate = T),
  hr(),
  sliderInput("sig.ln", label = h2(HTML("log[Std Dev] (ln[&sigma;])")),
              min = .5, max = 10, step = 0.5, value = 1, animate = T)),

mainPanel(width = 9,
 tabsetPanel(type = 'pills',
  tabPanel(h4('Distribution Function'),metricsgraphicsOutput("lnorC",height = "600px")),
  tabPanel(h4('Density'),    metricsgraphicsOutput("lnorP",height = "600px")),
  tabPanel(h4('Survival'),               metricsgraphicsOutput("lnorR",height = "600px")),
  tabPanel(h4('Hazard'),                 metricsgraphicsOutput("lnorh",height = "600px")),
  tabPanel(h4('Cumulative Hazard'),      metricsgraphicsOutput("lnorH",height = "600px")),
  tabPanel(h4('Quantile'),               metricsgraphicsOutput("lnorQ",height = "600px")))))),

server = function(input, output, session) {

t = reactive({ signif(seq(min(input$range.ln), max(input$range.ln), length = 500), digits = 4)})
p <- signif(seq(0, 1, length = 500), digits = 4) 
C <- reactive({ plnorm(t(), log(input$mu.ln), input$sig.ln)})
P <- reactive({ dlnorm(t(), log(input$mu.ln), input$sig.ln)})
R <- reactive({ 1-C()})
h <- reactive({ exp(log(P())/log(R()))})
H <- reactive({ -1*log(1-plnorm(t(), log(input$mu.ln), input$sig.ln))})
Q <- reactive({ qlnorm(p, log(input$mu.ln), input$sig.ln)})
df <- reactive({data.frame(Time = t(),PROB = p, CDF = C(),PDF = P(),REL = R(),haz = h(),HAZ = H(), QUANT = Q())})

  output$lnorC <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'F(t)')%>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")}) 
  
  output$lnorP <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'f(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$lnorR <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'S(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$lnorh <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'h(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$lnorH <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'H(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$lnorQ <- renderMetricsgraphics({
  mjs_plot(df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Probability (p)', y_label = 't(p)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
})
}
