library( package = 'metricsgraphics')










  
get('arg2', envir = .GlobalEnv, inherits = T)

shinyApp(options = list(height = "700px"),
         
ui = navbarPage(windowTitle = 'Poisson Distribution', 
              theme = shinythemes::shinytheme(theme = arg2$theme),
              try(includeCSS(system.file('css',
                                          'my-shiny.css', 
                                          package = 'teachingApps')), silent = TRUE),
tabPanel(h4('Shiny App'),
sidebarLayout(
  sidebarPanel(width = 3, 
hr(), 
sliderInput("range.pois", 
            label = h2("Range"),
            min = 0, 
            max = 50, 
            step = 1,
            value = c(0,10)),
hr(), 
sliderInput("lamb.pois", 
            label = h2("Lambda"),
            min = .5, 
            max = 10, 
            step=.5, 
            value = .5,
            animate=TRUE)), 

mainPanel(width = 9, 
          tabsetPanel(type = "pills", 
          tabPanel(h4("Distribution Function"), 
                   metricsgraphicsOutput("poisC", height = "600px")), 
          tabPanel(h4("Mass"),
                   metricsgraphicsOutput("poisP", height = "600px")), 
          tabPanel(h4("Survival"), 
                   metricsgraphicsOutput("poisR", height = "600px")), 
          tabPanel(h4("Hazard"), 
                   metricsgraphicsOutput("poish", height = "600px")), 
          tabPanel(h4("Cumulative Hazard"), 
                   metricsgraphicsOutput("poisH", height = "600px")),
          tabPanel(h4("Quantile"), 
                   metricsgraphicsOutput("poisQ", height = "600px")))))),

tabPanel(h4('Distribution Functions'),
         mainPanel(uiOutput('poifunc'), class = 'shiny-text-output', width = 12)),

tabPanel(h4('Distribution Properties'),
         mainPanel(uiOutput('poiprops', class = 'shiny-text-output'), width = 12)),

fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(arg2$appName))})

  t <- reactive({ min(input$range.pois):max(input$range.pois) })
  p <- reactive({ signif(seq(0, 1, length = length(max(t()):min(t()))), digits = 4) })
  C <- reactive({ ppois(t(), input$lamb.pois)})
  P <- reactive({ dpois(t(), input$lamb.pois)})
  R <- reactive({ 1 - C()})
  h <- reactive({ exp(log(P())-log(R()))})
  H <- reactive({ -1 * log(1 - ppois(t(),input$lamb.pois))})
  Q <- reactive({ qpois(p(),input$lamb.pois)})
 df <- reactive({ data.frame(Time = t(), 
                             PROB = p(), 
                             CDF = C(), 
                             PMF = P(), 
                             REL = R(), 
                             haz = h(), 
                             HAZ = H(),
                             QUANT = Q()
                             )})
 
      output$poisC <- renderMetricsgraphics({
        mjs_plot(df(), x = Time, y = CDF, decimals = 4, top = 0) %>% 
          mjs_point(point_size = 10)                              %>% 
          mjs_labs(x_label = "X = x", y_label = "F(x)")       %>% 
          mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
      })
      output$poisP <- renderMetricsgraphics({
        mjs_plot(df(), x = Time, y = PMF, decimals = 4)         %>% 
          mjs_point(point_size = 10)                             %>%
          mjs_labs(x_label = "X = x", y_label = "f(x)")      %>% 
          mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
      })
      output$poisR <- renderMetricsgraphics({
        mjs_plot(df(), x = Time, y = REL, decimals = 4)         %>% 
          mjs_point(point_size = 10)                             %>% 
          mjs_labs(x_label = "X = x", y_label = "S(x)")      %>% 
          mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
      })
      output$poish <- renderMetricsgraphics({
        mjs_plot(df(), x = Time, y = haz, decimals = 4) %>%
          mjs_point(point_size = 10)  %>%
          mjs_labs(x_label = "X = x", y_label = "h(x)") %>%
          mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
      })
      output$poisH <- renderMetricsgraphics({
        mjs_plot(df(), x = Time, y = HAZ, decimals = 4) %>% 
          mjs_point(point_size = 10)  %>% 
          mjs_labs(x_label = "X = x", y_label = "H(x)") %>% 
          mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
      })
      output$poisQ <- renderMetricsgraphics({
        mjs_plot(df(), x = PROB, y = QUANT, decimals = 4) %>%
          mjs_point(point_size = 10)  %>%
          mjs_labs(x_label = "Probability (p)", y_label = "x(p)") %>%
          mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
  
output$poifunc <- renderUI({ 
  withMathJax(HTML(includeMarkdown('poi-func.Rmd')))
})
output$poiprops <- renderUI({HTML(includeMarkdown('poi-props.Rmd'))
}) 
})
