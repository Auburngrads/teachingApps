server = function(input, output, session) {
  
exp.t = reactive({ signif(seq(min(input$rangee), max(input$rangee), length = 500), digits = 4)})
exp.p <- signif(seq(0, 1, length = 500), digits = 4) 
exp.C <- reactive({ pexp(exp.t() - input$gamma, 1/input$theta)})
exp.P <- reactive({ dexp(exp.t() - input$gamma, 1/input$theta)})
exp.R <- reactive({ 1-exp.C()})
exp.h <- reactive({ 1/input$theta })
exp.H <- reactive({ -1*log(1-pexp(exp.t() - input$gamma, 1/input$theta))})
exp.Q <- reactive({ input$gamma-log(1-exp.p)*input$theta})
exp.df <- reactive({data.frame(Time = exp.t(),PROB = exp.p, CDF = exp.C(),PDF = exp.P(),REL = exp.R(),haz = exp.h(),HAZ = exp.H(), QUANT = exp.Q())})

output$expC <- renderMetricsgraphics({
  mjs_plot(exp.df(), x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'F(t)')%>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
}) 
output$expP <- renderMetricsgraphics({
  mjs_plot(exp.df(), x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'f(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$expR <- renderMetricsgraphics({
  mjs_plot(exp.df(), x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'S(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$exph <- renderMetricsgraphics({
  mjs_plot(exp.df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'h(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$expH <- renderMetricsgraphics({
  mjs_plot(exp.df(), x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'H(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$expQ <- renderMetricsgraphics({
  mjs_plot(exp.df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Probability (p)', y_label = 't(p)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
}