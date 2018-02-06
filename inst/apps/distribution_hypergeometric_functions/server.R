server = function(input, output, session) {

  t <- reactive({ min(input$range.hyp):max(input$range.hyp) })
  p <- reactive({ signif(seq(0, 1, length = length(max(t()):min(t()))), digits = 4) })
  C <- reactive({ phyper(t(), input$m.hyp, input$n.hyp, input$k.hyp)})
  P <- reactive({ dhyper(t(), input$m.hyp, input$n.hyp, input$k.hyp)})
  R <- reactive({ 1 - C()})
  h <- reactive({ exp(log(P())-log(R()))})
  H <- reactive({ -1 * log(1 - phyper(t(),input$m.hyp, input$n.hyp, input$k.hyp))})
  Q <- reactive({ qhyper(p(),input$m.hyp, input$n.hyp, input$k.hyp)})
 df <- reactive({ data.frame(Time = t(), 
                             PROB = p(), 
                             CDF = C(), 
                             PMF = P(), 
                             REL = R(), 
                             haz = h(), 
                             HAZ = H(),
                             QUANT = Q()
                             )})
 
      output$hyperC <- renderMetricsgraphics({
        mjs_plot(df(), x = Time, y = CDF, decimals = 4, top = 0) %>% 
          mjs_point(point_size = 10)                              %>% 
          mjs_labs(x_label = "X = x", y_label = "F(x)")       %>% 
          mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
      })
      output$hyperP <- renderMetricsgraphics({
        mjs_plot(df(), x = Time, y = PMF, decimals = 4)         %>% 
          mjs_point(point_size = 10)                             %>%
          mjs_labs(x_label = "X = x", y_label = "f(x)")      %>% 
          mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
      })
      output$hyperR <- renderMetricsgraphics({
        mjs_plot(df(), x = Time, y = REL, decimals = 4)         %>% 
          mjs_point(point_size = 10)                             %>% 
          mjs_labs(x_label = "X = x", y_label = "S(x)")      %>% 
          mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
      })
      output$hyperh <- renderMetricsgraphics({
        mjs_plot(df(), x = Time, y = haz, decimals = 4) %>%
          mjs_point(point_size = 10)  %>%
          mjs_labs(x_label = "X = x", y_label = "h(x)") %>%
          mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
      })
      output$hyperH <- renderMetricsgraphics({
        mjs_plot(df(), x = Time, y = HAZ, decimals = 4) %>% 
          mjs_point(point_size = 10)  %>% 
          mjs_labs(x_label = "X = x", y_label = "H(x)") %>% 
          mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
      })
      output$hyperQ <- renderMetricsgraphics({
        mjs_plot(df(), x = PROB, y = QUANT, decimals = 4) %>%
          mjs_point(point_size = 10)  %>%
          mjs_labs(x_label = "Probability (p)", y_label = "x(p)") %>%
          mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
}