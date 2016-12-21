server = function(input, output, session) {
  
pois.t <- reactive({ min(input$range.pois):max(input$range.pois) })
pois.p <- reactive({ signif(seq(0, 1, length = length(max(pois.t()):min(pois.t()))), digits = 4) })
pois.C <- reactive({ ppois(pois.t(), input$lamb.pois)})
pois.P <- reactive({ dpois(pois.t(), input$lamb.pois)})
pois.R <- reactive({ 1 - pois.C()})
pois.h <- reactive({ exp(log(pois.P())-log(pois.R()))})
pois.H <- reactive({ -1 * log(1 - ppois(pois.t(),input$lamb.pois))})
pois.Q <- reactive({ qpois(p(),input$lamb.pois)})
pois.df <- reactive({ data.frame(Time = pois.t(), 
                             PROB = pois.p(), 
                             CDF = pois.C(), 
                             PMF = pois.P(), 
                             REL = pois.R(), 
                             haz = pois.h(), 
                             HAZ = pois.H(),
                             QUANT = pois.Q()
                             )})
 
output$poisC <- renderMetricsgraphics({
  mjs_plot(pois.df(), x = Time, y = CDF, decimals = 4, top = 0) %>% 
  mjs_point(point_size = 10)                              %>% 
  mjs_labs(x_label = "X = x", y_label = "F(x)")       %>% 
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$poisP <- renderMetricsgraphics({
  mjs_plot(pois.df(), x = Time, y = PMF, decimals = 4)         %>% 
  mjs_point(point_size = 10)                             %>%
  mjs_labs(x_label = "X = x", y_label = "f(x)")      %>% 
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$poisR <- renderMetricsgraphics({
  mjs_plot(pois.df(), x = Time, y = REL, decimals = 4)         %>% 
  mjs_point(point_size = 10)                             %>% 
  mjs_labs(x_label = "X = x", y_label = "S(x)")      %>% 
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$poish <- renderMetricsgraphics({
  mjs_plot(pois.df(), x = Time, y = haz, decimals = 4) %>%
  mjs_point(point_size = 10)  %>%
  mjs_labs(x_label = "X = x", y_label = "h(x)") %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$poisH <- renderMetricsgraphics({
  mjs_plot(pois.df(), x = Time, y = HAZ, decimals = 4) %>% 
  mjs_point(point_size = 10)  %>% 
  mjs_labs(x_label = "X = x", y_label = "H(x)") %>% 
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$poisQ <- renderMetricsgraphics({
  mjs_plot(pois.df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_point(point_size = 10)  %>%
  mjs_labs(x_label = "Probability (p)", y_label = "x(p)") %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$poifunc <- renderUI({ 
  withMathJax(HTML(includeMarkdown('poi-func.Rmd')))
})
output$poiprops <- renderUI({HTML(includeMarkdown('poi-props.Rmd'))
}) 
}