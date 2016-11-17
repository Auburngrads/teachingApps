library(teachingApps)
library(metricsgraphics)

shinyApp(options = list(height = "700px"),
         onStart = function() { options('markdown.HTML.stylesheet' = system.file('css','my-shiny.css', package = 'teachingApps'))}, 
         
ui = fluidPage(theme = shinythemes::shinytheme(theme = source('args.R')[[1]]$theme), 
               try(includeCSS(system.file("css", 
                                          "my-shiny.css", 
                                          package = "teachingApps")), silent = TRUE), 
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
                   metricsgraphicsOutput("betaQ", height = "600px"))))),

fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px')),

server = function(input, output, session) {

  output$sign <- renderUI({HTML(teachingApps::teachingApp(source('args.R')[[1]]$appName))})
  
  t <- reactive({ signif(seq(0,1, length.out = 500), digits = 4) + input$loc.beta })
  p <- reactive({ signif(seq(0, 1, length = 500), digits = 4) })
  C <- reactive({ pbeta(t(), input$shape1, input$shape2)})
  P <- reactive({ dbeta(t(), input$shape1, input$shape2)})
  R <- reactive({ 1 - C()})
  h <- reactive({ exp(log(P())-log(R()))})
  H <- reactive({ -1 * log(1 - pbeta(t(),input$shape1, input$shape2))})
  Q <- reactive({ qbeta(p(),input$shape1, input$shape2)})
 df <- reactive({ data.frame(Time = t(), 
                             PROB = p(), 
                             CDF = C(), 
                             PMF = P(), 
                             REL = R(), 
                             haz = h(), 
                             HAZ = H(),
                             QUANT = Q()
                             )})
 
      output$betaC <- renderMetricsgraphics({
        mjs_plot(df(), x = Time, y = CDF, decimals = 4, top = 0) %>% 
          mjs_line(area = TRUE)                              %>% 
          mjs_labs(x_label = "X = x", y_label = "F(x)")       %>% 
          mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
      output$betaP <- renderMetricsgraphics({
        mjs_plot(df(), x = Time, y = PMF, decimals = 4)         %>% 
          mjs_line(area = TRUE)                             %>%
          mjs_labs(x_label = "X = x", y_label = "f(x)")      %>% 
          mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
      output$betaR <- renderMetricsgraphics({
        mjs_plot(df(), x = Time, y = REL, decimals = 4)         %>% 
          mjs_line(area = TRUE)                             %>% 
          mjs_labs(x_label = "X = x", y_label = "S(x)")      %>% 
          mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
      output$betah <- renderMetricsgraphics({
        mjs_plot(df(), x = Time, y = haz, decimals = 4) %>%
          mjs_line(area = TRUE)  %>%
          mjs_labs(x_label = "X = x", y_label = "h(x)") %>%
          mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
      output$betaH <- renderMetricsgraphics({
        mjs_plot(df(), x = Time, y = HAZ, decimals = 4) %>% 
          mjs_line(area = TRUE)  %>% 
          mjs_labs(x_label = "X = x", y_label = "H(x)") %>% 
          mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
      output$betaQ <- renderMetricsgraphics({
        mjs_plot(df(), x = PROB, y = QUANT, decimals = 4) %>%
          mjs_line(area = TRUE)  %>%
          mjs_labs(x_label = "Probability (p)", y_label = "x(p)") %>%
          mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
})
