server = function(input, output, session) {
  
t <-  reactive({ signif(seq(input$rangeigau[1], input$rangeigau[2], length = 500), digits = 4) })
p <-  reactive({ signif(seq(0.001, .999, length = 500), digits = 4) })
C <-  reactive({ pigau(t(), input$be.igau,input$th.igau)})
P <-  reactive({ digau(t(), input$be.igau,input$th.igau)})
R <-  reactive({ 1-C()})
h <-  reactive({ exp(log(P())-log(R()))})
H <-  reactive({ -1*log(1-pigau(t(), input$be.igau,input$th.igau))})
Q <-  reactive({ qigau(p(), input$be.igau,input$th.igau) })
df <- reactive({ data.frame(Time = t(),PROB = p(), CDF = C(),PDF = P(),REL = R(),haz = h(),HAZ = H(), QUANT = Q()) })

  output$igauC <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'F(t)')%>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")}) 
  
  output$igauP <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'f(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$igauR <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'S(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$igauh <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'h(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$igauH <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'H(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$igauQ <- renderMetricsgraphics({
  mjs_plot(df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Probability (p)', y_label = 't(p)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
}