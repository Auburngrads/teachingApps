server = function(input, output, session) {
  
geom.t <- reactive({ min(input$range.geom):max(input$range.geom) })
geom.p <- reactive({ signif(seq(0, 1, length = length(max(geom.t()):min(geom.t()))), digits = 4) })
geom.C <- reactive({ pgeom(geom.t(), input$prob.geom)})
geom.P <- reactive({ dgeom(geom.t(), input$prob.geom)})
geom.R <- reactive({ 1 - geom.C()})
geom.h <- reactive({ exp(log(geom.P())-log(geom.R()))})
geom.H <- reactive({ -1 * log(1 - pgeom(geom.t(),input$prob.geom))})
geom.Q <- reactive({ qgeom(geom.p(),input$prob.geom)})
geom.df <- reactive({ data.frame(Time = geom.t(), 
                             PROB = geom.p(), 
                             CDF = geom.C(), 
                             PMF = geom.P(), 
                             REL = geom.R(), 
                             haz = geom.h(), 
                             HAZ = geom.H(),
                             QUANT = geom.Q()
                             )})
 
output$geomC <- renderMetricsgraphics({
  mjs_plot(geom.df(), x = Time, y = CDF, decimals = 4, top = 0) %>% 
  mjs_point(point_size = 10)                              %>% 
  mjs_labs(x_label = "X = x", y_label = "F(x)")       %>% 
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$geomP <- renderMetricsgraphics({
  mjs_plot(geom.df(), x = Time, y = PMF, decimals = 4)         %>% 
  mjs_point(point_size = 10)                             %>%
  mjs_labs(x_label = "X = x", y_label = "f(x)")      %>% 
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$geomR <- renderMetricsgraphics({
  mjs_plot(geom.df(), x = Time, y = REL, decimals = 4)         %>% 
  mjs_point(point_size = 10)                             %>% 
  mjs_labs(x_label = "X = x", y_label = "S(x)")      %>% 
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$geomh <- renderMetricsgraphics({
  mjs_plot(geom.df(), x = Time, y = haz, decimals = 4) %>%
  mjs_point(point_size = 10)  %>%
  mjs_labs(x_label = "X = x", y_label = "h(x)") %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$geomH <- renderMetricsgraphics({
  mjs_plot(geom.df(), x = Time, y = HAZ, decimals = 4) %>% 
  mjs_point(point_size = 10)  %>% 
  mjs_labs(x_label = "X = x", y_label = "H(x)") %>% 
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$geomQ <- renderMetricsgraphics({
  mjs_plot(geom.df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_point(point_size = 10)  %>%
  mjs_labs(x_label = "Probability (p)", y_label = "x(p)") %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$geofunc <- renderUI({ 
  withMathJax(HTML(includeMarkdown('geo-func.Rmd')))
})
output$geoprops <- renderUI({HTML(includeMarkdown('geo-props.Rmd'))
}) 
}