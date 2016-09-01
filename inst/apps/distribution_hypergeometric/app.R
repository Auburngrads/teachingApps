teachingApps::getPackage("metricsgraphics")
  
shinyApp(options = list(height = "700px"), 
         
ui = fluidPage(theme = shinythemes::shinytheme("flatly"), 
               try(includeCSS(system.file("css", 
                                          "my-shiny.css", 
                                          package = "teachingApps")), silent = TRUE), 
sidebarLayout(
  sidebarPanel(width = 3, 
sliderInput("m.hyp", 
            label = h2("Number of Success States (m)"),
            min = .05, 
            max = 1, 
            step=.05, 
            value = .05,
            animate=TRUE),
sliderInput("n.hyp", 
            label = h2("Number of Failure States (n)"),
            min = 0, 
            max = 50, 
            step = 1,
            value = 2),
sliderInput("k.hyp", 
            label = h2("Number of draws (k)"),
            min = .05, 
            max = 1, 
            step=.05, 
            value = .05,
            animate=TRUE)), 

mainPanel(width = 9, 
          tabsetPanel(type = "pills", 
          tabPanel(h4("Distribution Function"), 
                   metricsgraphicsOutput("hypC", height = "600px")), 
          tabPanel(h4("Mass"),
                   metricsgraphicsOutput("hypP", height = "600px")), 
          tabPanel(h4("Survival"), 
                   metricsgraphicsOutput("hypR", height = "600px")), 
          tabPanel(h4("Hazard"), 
                   metricsgraphicsOutput("hyph", height = "600px")), 
          tabPanel(h4("Cumulative Hazard"), 
                   metricsgraphicsOutput("hypH", height = "600px")),
          tabPanel(h4("Quantile"), 
                   metricsgraphicsOutput("hypQ", height = "600px")))
))), 

server = function(input, output, session) {

  t <- reactive({ input$N.hyp })
  p <- reactive({ signif(seq(0, 1, length = length(max(t()):min(t()))), digits = 4) })
  C <- reactive({ pgeom(t(), input$prob.geom)})
  P <- reactive({ dgeom(t(), input$prob.geom)})
  R <- reactive({ 1 - C()})
  h <- reactive({ exp(log(P())-log(R()))})
  H <- reactive({ -1 * log(1 - pgeom(t(),input$prob.geom))})
  Q <- reactive({ qgeom(p(),input$prob.geom)})
 df <- reactive({ data.frame(Time = t(), 
                             PROB = p(), 
                             CDF = C(), 
                             PMF = P(), 
                             REL = R(), 
                             haz = h(), 
                             HAZ = H(),
                             QUANT = Q()
                             )})
 
      output$geomC <- renderMetricsgraphics({
        mjs_plot(df(), x = Time, y = CDF, decimals = 4, top = 0) %>% 
          mjs_point(point_size = 10)                              %>% 
          mjs_labs(x_label = "X = x", y_label = "F(x)")       %>% 
          mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
      })
      output$geomP <- renderMetricsgraphics({
        mjs_plot(df(), x = Time, y = PMF, decimals = 4)         %>% 
          mjs_point(point_size = 10)                             %>%
          mjs_labs(x_label = "X = x", y_label = "f(x)")      %>% 
          mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
      })
      output$geomR <- renderMetricsgraphics({
        mjs_plot(df(), x = Time, y = REL, decimals = 4)         %>% 
          mjs_point(point_size = 10)                             %>% 
          mjs_labs(x_label = "X = x", y_label = "S(x)")      %>% 
          mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
      })
      output$geomh <- renderMetricsgraphics({
        mjs_plot(df(), x = Time, y = haz, decimals = 4) %>%
          mjs_point(point_size = 10)  %>%
          mjs_labs(x_label = "X = x", y_label = "h(x)") %>%
          mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
      })
      output$geomH <- renderMetricsgraphics({
        mjs_plot(df(), x = Time, y = HAZ, decimals = 4) %>% 
          mjs_point(point_size = 10)  %>% 
          mjs_labs(x_label = "X = x", y_label = "H(x)") %>% 
          mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
      })
      output$geomQ <- renderMetricsgraphics({
        mjs_plot(df(), x = PROB, y = QUANT, decimals = 4) %>%
          mjs_point(point_size = 10)  %>%
          mjs_labs(x_label = "Probability (p)", y_label = "x(p)") %>%
          mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
})
