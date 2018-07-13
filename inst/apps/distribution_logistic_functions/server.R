server = function(input, output, session) {
  
log.t = reactive({ signif(seq(min(input$range.l), max(input$range.l), length = 500), digits = 4)})
log.p <- signif(seq(0, 1, length = 500), digits = 4) 
log.C <- reactive({ plogis(log.t(), input$mu.l, input$sig.l)})
log.P <- reactive({ dlogis(log.t(), input$mu.l, input$sig.l)})
log.R <- reactive({ 1-log.C()})
log.h <- reactive({ exp(log(log.P())-log(log.R()))})
log.H <- reactive({ -1*log(1-plogis(log.t(), input$mu.l, input$sig.l))})
log.Q <- reactive({ qlogis(log.p, input$mu.l, input$sig.l)})
log.df <- reactive({data.frame(Time  = log.t(),
                               PROB  = log.p, 
                               CDF   = log.C(),
                               PDF   = log.P(),
                               REL   = log.R(),
                               haz   = log.h(),
                               HAZ   = log.H(), 
                               QUANT = log.Q())})

  output$logC <- renderMetricsgraphics({
  mjs_plot(log.df(), x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'F(t)')%>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")}) 
  
  output$logP <- renderMetricsgraphics({
  mjs_plot(log.df(), x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'f(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$logR <- renderMetricsgraphics({
  mjs_plot(log.df(), x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'S(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$logh <- renderMetricsgraphics({
  mjs_plot(log.df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'h(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$logH <- renderMetricsgraphics({
  mjs_plot(log.df(), x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'H(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$logQ <- renderMetricsgraphics({
  mjs_plot(log.df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Probability (p)', y_label = 't(p)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
}