server = function(input, output, session) {
  
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
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
}) 
output$lnorP <- renderMetricsgraphics({
  mjs_plot(ln.df(), x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'f(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$lnorR <- renderMetricsgraphics({
  mjs_plot(ln.df(), x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'S(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$lnorh <- renderMetricsgraphics({
  mjs_plot(ln.df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'h(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$lnorH <- renderMetricsgraphics({
  mjs_plot(ln.df(), x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'H(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$lnorQ <- renderMetricsgraphics({
  mjs_plot(ln.df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Probability (p)', y_label = 't(p)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
}