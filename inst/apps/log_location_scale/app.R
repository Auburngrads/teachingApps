library(teachingApps)
library(metricsgraphics)
library(SMRD)
library(actuar)

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
  hr(),
  sliderInput("mu.ln", 
              label = h2(HTML("Log[Mean] (ln[&mu;])")),
              min = 0, 
              max = 10, 
              step = 0.5, 
              value = 4, 
              animate = T),
  hr(),
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
  tabPanel(h4(HTML('CDF <script type="math/tex">F(t)</script>')),  
           metricsgraphicsOutput("lnorC",height = "600px")),
  tabPanel(h4(HTML('PDF <script type="math/tex">f(t)</script>')),                
           metricsgraphicsOutput("lnorP",height = "600px")),
  tabPanel(h4(HTML('Survival <script type="math/tex">S(t)</script>')),
           metricsgraphicsOutput("lnorR",height = "600px")),
  tabPanel(h4(HTML('Hazard <script type="math/tex">h(t)</script>')),
           metricsgraphicsOutput("lnorh",height = "600px")),
  tabPanel(h4(HTML('Cum Hazard <script type="math/tex">H(t)</script>')),
           metricsgraphicsOutput("lnorH",height = "600px")),
  tabPanel(h4(HTML('Quantile <script type="math/tex">F^{-1}(p)</script>')),
           metricsgraphicsOutput("lnorQ",height = "600px"))))))),

##########################
tabPanel(h4('Weibull'),
##########################
fluidRow(
  column(width = 12,
     mainPanel(uiOutput('weibfunc'),
                     class = 'shiny-text-output', width = '100%'))),

fluidRow(
  column(width = 12,
     mainPanel(uiOutput('weibprops'),
                     class = 'shiny-text-output', width = '100%'))),

fluidRow(
  column(width = 12, h3('Interactive Shiny App'))),

fluidRow(
  column(width = 3,
  sidebarPanel(width = '100%',
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
              animate = T))),

column(width = 9,
    mainPanel(width = '100%',
 tabsetPanel(type = 'pills',
  tabPanel(h4('Distribution Function'),  metricsgraphicsOutput("weibC",height = "600px")),
  tabPanel(h4('Density'),                metricsgraphicsOutput("weibP",height = "600px")),
  tabPanel(h4('Survival'),               metricsgraphicsOutput("weibR",height = "600px")),
  tabPanel(h4('Hazard'),                 metricsgraphicsOutput("weibh",height = "600px")),
  tabPanel(h4('Cumulative Hazard'),      metricsgraphicsOutput("weibH",height = "600px")),
  tabPanel(h4('Quantile'),               metricsgraphicsOutput("weibQ",height = "600px"))))))),

##########################
tabPanel(h4('Loglogistic'),
##########################
fluidRow(
  column(width = 12,
     mainPanel(uiOutput('llogisfunc'),
                     class = 'shiny-text-output', width = '100%'))),

fluidRow(
  column(width = 12,
     mainPanel(uiOutput('llogisprops'),
                     class = 'shiny-text-output', width = '100%'))),

fluidRow(
  column(width = 12, h3('Interactive Shiny App'))),

fluidRow(
  column(width = 3,
  sidebarPanel(width = '100%',
  sliderInput("range.ll", 
              label = h2("Range"),
              min = 0, 
              max = 50, 
              value = c(0,20)),
  hr(),
  sliderInput("mu.ll", 
              label = h2(HTML("Mean (&mu;)")),
              min = 0.5, 
              max = 10, 
              step = 0.5, 
              value = 0.5, 
              animate = T),
  hr(),
  sliderInput("sig.ll", 
              label = h2(HTML("Std Dev (&sigma;)")),
              min = 0.5, 
              max = 10, 
              step = 0.5, 
              value = 1, 
              animate = T))),

column(width = 9,
    mainPanel(width = '100%',
 tabsetPanel(type = 'pills',
  tabPanel(h4('Distribution Function'),  metricsgraphicsOutput("llogC",height = "600px")),
  tabPanel(h4('Density'),                metricsgraphicsOutput("llogP",height = "600px")),
  tabPanel(h4('Survival'),               metricsgraphicsOutput("llogR",height = "600px")),
  tabPanel(h4('Hazard'),                 metricsgraphicsOutput("llogh",height = "600px")),
  tabPanel(h4('Cumulative Hazard'),      metricsgraphicsOutput("llogH",height = "600px")),
  tabPanel(h4('Quantile'),               metricsgraphicsOutput("llogQ",height = "600px")))))))
),

server = function(input, output, session) {

output$overview <- renderUI({ 
  withMathJax(HTML(includeMarkdown('background.Rmd')))
})

######################
# Lognormal Server #
######################
output$lnorfunc <- renderUI({ 
  withMathJax(HTML(includeMarkdown(system.file('apps','distribution_lognormal_full','lnor-func.Rmd', package = 'teachingApps'))))
})
output$lnorprops <- renderUI({
  HTML(includeMarkdown(system.file('apps','distribution_lognormal_full','lnor-props.Rmd', package = 'teachingApps')))
})

ln.t = reactive({ signif(seq(min(input$range.ln), max(input$range.ln), length = 500), digits = 4)})
ln.p <- signif(seq(0, 1, length = 500), digits = 4) 
ln.C <- reactive({ plnorm(ln.t(), log(input$mu.ln), input$sig.ln)})
ln.P <- reactive({ dlnorm(ln.t(), log(input$mu.ln), input$sig.ln)})
ln.R <- reactive({ 1-ln.C()})
ln.h <- reactive({ exp(log(ln.P())-log(ln.R()))})
ln.H <- reactive({ -1*log(1-plnorm(ln.t(), log(input$mu.ln), input$sig.ln))})
ln.Q <- reactive({ qlnorm(ln.p, log(input$mu.ln), input$sig.ln)})
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
  
######################
# Weibull Server #
######################
output$weibfunc <- renderUI({ 
  withMathJax(HTML(includeMarkdown(system.file('apps','distribution_weibull_full','weib-func.Rmd', package = 'teachingApps'))))
})
output$weibprops <- renderUI({
  HTML(includeMarkdown(system.file('apps','distribution_weibull_full','weib-props.Rmd', package = 'teachingApps')))
})

weibhaz <-function(x,sc, sh) {sh/sc*(x/sc)^(sh-1)}

weib.t = reactive({ signif(seq(min(input$range.w), max(input$range.w), length = 500), digits = 4)})
weib.p <- signif(seq(0, 1, length = 500), digits = 4) 
weib.C <- reactive({ pweibull(weib.t(), input$shape.w, input$scale.w)})
weib.P <- reactive({ dweibull(weib.t(), input$shape.w, input$scale.w)})
weib.R <- reactive({ 1-weib.C()})
weib.h <- reactive({ weibhaz(weib.t(), input$scale.w, input$shape.w)})
weib.H <- reactive({ -1*log(1-pweibull(weib.t(), input$shape.w, input$scale.w))})
weib.Q <- reactive({ qweibull(weib.p, input$shape.w, input$scale.w)})
weib.df <- reactive({data.frame(Time = weib.t(),PROB = weib.p, CDF = weib.C(),PDF = weib.P(),REL = weib.R(),haz = weib.h(),HAZ = weib.H(), QUANT = weib.Q())})

  output$weibC <- renderMetricsgraphics({
  mjs_plot(weib.df(), x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'F(t)')%>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")}) 
  
  output$weibP <- renderMetricsgraphics({
  mjs_plot(weib.df(), x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'f(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$weibR <- renderMetricsgraphics({
  mjs_plot(weib.df(), x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'S(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$weibh <- renderMetricsgraphics({
  mjs_plot(weib.df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'h(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$weibH <- renderMetricsgraphics({
  mjs_plot(weib.df(), x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'H(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$weibQ <- renderMetricsgraphics({
  mjs_plot(weib.df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Probability (p)', y_label = 't(p)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})

######################
# Loglogistic Server #
######################
output$llogisfunc <- renderUI({ 
  withMathJax(HTML(includeMarkdown(system.file('apps','distribution_loglogistic_full','llog-func.Rmd', package = 'teachingApps'))))
})
output$llogisprops <- renderUI({
  HTML(includeMarkdown(system.file('apps','distribution_loglogistic_full','llog-props.Rmd', package = 'teachingApps')))
})
ll.t = reactive({ signif(seq(min(input$range.ll), max(input$range.ll), length = 500), digits = 4)})
ll.p <- signif(seq(0, 1, length = 500), digits = 4) 
ll.C <- reactive({ pllogis(ll.t(), input$mu.ll, input$sig.ll)})
ll.P <- reactive({ dllogis(ll.t(), input$mu.ll, input$sig.ll)})
ll.R <- reactive({ 1-ll.C()})
ll.h <- reactive({ exp(log(ll.P())-log(ll.R()))})
ll.H <- reactive({ -1*log(1-pllogis(ll.t(), input$mu.ll, input$sig.ll))})
ll.Q <- reactive({ qllogis(ll.p, input$mu.ll, input$sig.ll)})
ll.df <- reactive({data.frame(Time = ll.t(),PROB = ll.p, CDF = ll.C(),PDF = ll.P(),REL = ll.R(),haz = ll.h(),HAZ = ll.H(), QUANT = ll.Q())})

  output$llogC <- renderMetricsgraphics({
  mjs_plot(ll.df(), x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'F(t)')%>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")}) 
  
  output$llogP <- renderMetricsgraphics({
  mjs_plot(ll.df(), x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'f(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$llogR <- renderMetricsgraphics({
  mjs_plot(ll.df(), x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'S(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$llogh <- renderMetricsgraphics({
  mjs_plot(ll.df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'h(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$llogH <- renderMetricsgraphics({
  mjs_plot(ll.df(), x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'H(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$llogQ <- renderMetricsgraphics({
  mjs_plot(ll.df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Probability (p)', y_label = 't(p)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
})

