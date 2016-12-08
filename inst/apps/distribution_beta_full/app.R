library(teachingApps)
library('metricsgraphics')

shinyApp(options = list(height = "700px"),
         onStart = function() { options('markdown.HTML.stylesheet' = system.file('css','my-shiny.css', package = 'teachingApps'))},
         
ui = navbarPage(collapsible = T, 
                position = 'fixed-top',
                title = 'Beta Distribution',
                theme = shinythemes::shinytheme(theme = 'flatly'),
                header = tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
                footer = HTML(teachingApps::teachingApp('global')),
                
tabPanel(h4('Shiny App'),
sidebarLayout(
  sidebarPanel(width = 3, 
sliderInput("shape1", 
            label = h2(HTML("Shape Parameter (&alpha;)")),
            min = .5, 
            max = 10, 
            step=.5, 
            value = 2,
            animate=TRUE),
sliderInput("shape2", 
            label = h2(HTML("Shape Parameter (&beta;)")),
            min = .5, 
            max = 10, 
            step = .5,
            value = .5),
sliderInput("scale.beta", 
            label = h2("Scale Parameter (d)"),
            min = 1, 
            max = 20, 
            step = 1, 
            value = 1,
            animate=TRUE),
sliderInput("loc.beta", 
            label = h2("Location Parameter (c)"),
            min = 0, 
            max = 10, 
            step = .5, 
            value = 0,
            animate=TRUE)), 

mainPanel(width = 9, 
          tabsetPanel(type = "pills", 
          tabPanel(h4("Distribution Function"), 
                   metricsgraphicsOutput("betaC", height = "600px")), 
          tabPanel(h4("Mass"),
                   metricsgraphicsOutput("betaP", height = "600px")), 
          tabPanel(h4("Survival"), 
                   metricsgraphicsOutput("betaR", height = "600px")), 
          tabPanel(h4("Hazard"), 
                   metricsgraphicsOutput("betah", height = "600px")), 
          tabPanel(h4("Cumulative Hazard"), 
                   metricsgraphicsOutput("betaH", height = "600px")),
          tabPanel(h4("Quantile"), 
                   metricsgraphicsOutput("betaQ", height = "600px")))))),

tabPanel(h4('Distribution Functions'),
         mainPanel(uiOutput('betafunc'), class = 'shiny-text-output', width = 12)),

tabPanel(h4('Distribution Properties'),
         mainPanel(uiOutput('betaprops', class = 'shiny-text-output'), width = 12))),

server = function(input, output, session) {
  
beta.t <- reactive({ signif(seq(0,1, length.out = 500), digits = 4) + input$loc.beta })
beta.p <- reactive({ signif(seq(0, 1, length = 500), digits = 4) })
beta.C <- reactive({ pbeta(beta.t(), input$shape1, input$shape2)})
beta.P <- reactive({ dbeta(beta.t(), input$shape1, input$shape2)})
beta.R <- reactive({ 1 - beta.C()})
beta.h <- reactive({ exp(log(beta.P())-log(beta.R()))})
beta.H <- reactive({ -1 * log(1 - pbeta(beta.t(),input$shape1, input$shape2))})
beta.Q <- reactive({ qbeta(beta.p(),input$shape1, input$shape2)})
beta.df <- reactive({ data.frame(Time = beta.t(), 
                             PROB = beta.p(), 
                             CDF = beta.C(), 
                             PMF = beta.P(), 
                             REL = beta.R(), 
                             haz = beta.h(), 
                             HAZ = beta.H(),
                             QUANT = beta.Q()
                             )})
 
output$betaC <- renderMetricsgraphics({
  mjs_plot(beta.df(), x = Time, y = CDF, decimals = 4, top = 0) %>% 
  mjs_line(area = TRUE)                              %>% 
  mjs_labs(x_label = "X = x", y_label = "F(x)")       %>% 
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$betaP <- renderMetricsgraphics({
  mjs_plot(beta.df(), x = Time, y = PMF, decimals = 4)         %>% 
  mjs_line(area = TRUE)                             %>%
  mjs_labs(x_label = "X = x", y_label = "f(x)")      %>% 
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$betaR <- renderMetricsgraphics({
  mjs_plot(beta.df(), x = Time, y = REL, decimals = 4)         %>% 
  mjs_line(area = TRUE)                             %>% 
  mjs_labs(x_label = "X = x", y_label = "S(x)")      %>% 
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$betah <- renderMetricsgraphics({
  mjs_plot(beta.df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE)  %>%
  mjs_labs(x_label = "X = x", y_label = "h(x)") %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$betaH <- renderMetricsgraphics({
  mjs_plot(beta.df(), x = Time, y = HAZ, decimals = 4) %>% 
  mjs_line(area = TRUE)  %>% 
  mjs_labs(x_label = "X = x", y_label = "H(x)") %>% 
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$betaQ <- renderMetricsgraphics({
  mjs_plot(beta.df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE)  %>%
  mjs_labs(x_label = "Probability (p)", y_label = "x(p)") %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$betafunc <- renderUI({ 
  withMathJax(HTML(includeMarkdown(paste(c(arg2$appDir,'beta-func.Rmd'),collapse = '/'))))
})
output$betaprops <- renderUI({
  HTML(includeMarkdown(paste(c(arg2$appDir,'beta-props.Rmd'), collapse = '/')))
}) 
})
