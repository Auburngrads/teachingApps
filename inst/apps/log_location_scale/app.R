library(teachingApps)
library(metricsgraphics)
library(SMRD)

shinyApp(options = list(width = "100%", height = "800px"),
         
ui = navbarPage(collapsible = T, 
                position = 'fixed-top',
                title = 'Log-Location-Scale Family',
                theme = shinythemes::shinytheme(theme = source('www/args.R')[[1]]$theme),
                header = tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
                footer = HTML(teachingApps::teachingApp(source('www/args.R')[[1]]$appName)),

tabPanel(h4('Overview'),
         mainPanel(uiOutput('overview'), 
                   class = 'shiny-text-output', 
                   width = 12)),
##########################
tabPanel(h4('Lognormal'),
##########################
fluidRow(
  column(width = 12,
     mainPanel(uiOutput('lnorfunc'),
                     class = 'shiny-text-output', width = '100%'))),

fluidRow(
  column(width = 12,
     mainPanel(uiOutput('lnorprops'),
                     class = 'shiny-text-output', width = '100%'))),

fluidRow(
  column(width = 12, h3('Interactive Shiny App'))),

fluidRow(
  column(width = 3,
  sidebarPanel(width = '100%',
  sliderInput("range.ln", 
              label = h2("Range:"),
              min = 0, 
              max = 50, 
              value = c(0,20)),
  sliderInput("mu.ln", 
              label = h2(HTML("Log[Mean] (ln[&mu;])")),
              min = 0, 
              max = 10, 
              step = 0.5, 
              value = 4, 
              animate = T),
  sliderInput("sig.ln", 
              label = h2(HTML("log[Std Dev] (ln[&sigma;])")),
              min = .5, 
              max = 10, 
              step = 0.5, 
              value = 1, 
              animate = T))),

column(width = 9,
    mainPanel(width = '100%',
 tabsetPanel(type = 'pills',
  tabPanel(h4('Distribution Function'),  metricsgraphicsOutput("lnorC",height = "600px")),
  tabPanel(h4('Density'),                metricsgraphicsOutput("lnorP",height = "600px")),
  tabPanel(h4('Survival'),               metricsgraphicsOutput("lnorR",height = "600px")),
  tabPanel(h4('Hazard'),                 metricsgraphicsOutput("lnorh",height = "600px")),
  tabPanel(h4('Cumulative Hazard'),      metricsgraphicsOutput("lnorH",height = "600px")),
  tabPanel(h4('Quantile'),               metricsgraphicsOutput("lnorQ",height = "600px")))))))),

server = function(input, output, session) {

output$overview <- renderUI({ 
  withMathJax(HTML(includeMarkdown('background.Rmd')))
})

######################
# Lognormal Server #
######################
output$lnorfunc <- renderUI({ 
  withMathJax(HTML(includeMarkdown(system.file('apps','distribution_lognormal_full','exp-func.Rmd', package = 'teachingApps'))))
})
output$lnorprops <- renderUI({
  HTML(includeMarkdown(system.file('apps','distribution_lognormal_full','exp-props.Rmd', package = 'teachingApps')))
})

ln.t = reactive({ signif(seq(min(input$range.ln), max(input$range.ln), length = 500), digits = 4)})
ln.p <- signif(seq(0, 1, length = 500), digits = 4) 
ln.C <- reactive({ plnorm(ln.t(), log(input$mu.ln), input$sig.ln)})
ln.P <- reactive({ dlnorm(ln.t(), log(input$mu.ln), input$sig.ln)})
ln.R <- reactive({ 1-ln.C()})
ln.h <- reactive({ exp(log(ln.P())-log(ln.R()))})
ln.H <- reactive({ -1*log(1-plnorm(ln.t(), log(input$mu.ln), input$sig.ln))})
ln.Q <- reactive({ qlnorm(p, log(input$mu.ln), input$sig.ln)})
ln.df <- reactive({data.frame(Time = ln.t(),PROB = ln.p, CDF = ln.C(),PDF = ln.P(),REL = ln.R(),haz = ln.h(),HAZ = ln.H(), QUANT = ln.Q())})

  output$lnorC <- renderMetricsgraphics({
  mjs_plot(ln.df(), x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'F(t)')%>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")}) 
  
  output$lnorP <- renderMetricsgraphics({
  mjs_plot(ln.df(), x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'f(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$lnorR <- renderMetricsgraphics({
  mjs_plot(ln.df(), x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'S(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$lnorh <- renderMetricsgraphics({
  mjs_plot(ln.df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'h(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$lnorH <- renderMetricsgraphics({
  mjs_plot(ln.df(), x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'H(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$lnorQ <- renderMetricsgraphics({
  mjs_plot(ln.df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Probability (p)', y_label = 't(p)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
})
