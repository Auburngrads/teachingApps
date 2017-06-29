server = function(input, output, session) {

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
}