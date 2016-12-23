server = function(input, output, session) {

  t <- reactive({ min(input$range.bin):max(input$range.bin) })
  p <- reactive({ signif(seq(0, 1, length = length(max(t()):min(t()))), digits = 4) })
  C <- reactive({ pbinom(t(), input$n.bin,input$prob.bin)})
  P <- reactive({ dbinom(t(), input$n.bin,input$prob.bin)})
  R <- reactive({ 1 - C()})
  h <- reactive({ exp(log(P())-log(R()))})
  H <- reactive({ -1 * log(1 - pbinom(t(),input$n.bin,input$prob.bin))})
  Q <- reactive({ qbinom(p(),input$n.bin,input$prob.bin)})
 df <- reactive({ data.frame(Time = t(), 
                             PROB = p(), 
                             CDF = C(), 
                             PDF = P(), 
                             REL = R(), 
                             haz = h(), 
                             HAZ = H(),
                             QUANT = Q()
                             )})
 
output$binC <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = CDF, decimals = 4, top = 0) %>% 
    mjs_point(point_size = 10)                              %>% 
    mjs_labs(x_label = "Time (t)", y_label = "F(t)")       %>% 
    mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$binP <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = PDF, decimals = 4)         %>% 
    mjs_point(point_size = 10)                             %>%
    mjs_labs(x_label = "Time (t)", y_label = "f(t)")      %>% 
    mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$binR <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = REL, decimals = 4)         %>% 
    mjs_point(point_size = 10)                             %>% 
    mjs_labs(x_label = "Time (t)", y_label = "S(t)")      %>% 
    mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$binh <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = haz, decimals = 4) %>%
    mjs_point(point_size = 10)  %>%
    mjs_labs(x_label = "Time (t)", y_label = "h(t)") %>%
    mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$binH <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = HAZ, decimals = 4) %>% 
    mjs_point(point_size = 10)  %>% 
    mjs_labs(x_label = "Time (t)", y_label = "H(t)") %>% 
    mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$binQ <- renderMetricsgraphics({
  mjs_plot(df(), x = PROB, y = QUANT, decimals = 4) %>%
    mjs_point(point_size = 10)  %>%
    mjs_labs(x_label = "Probability (p)", y_label = "t(p)") %>%
    mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
}