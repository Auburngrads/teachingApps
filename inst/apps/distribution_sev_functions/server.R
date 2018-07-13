server = function(input, output, session) {
  
sev.t = reactive({ signif(seq(min(input$range.s), max(input$range.s), length = 500), digits = 4)})
sev.p <- signif(seq(0, 1, length = 500), digits = 4) 
sev.C <- reactive({ psev(sev.t(), input$mu.sev, input$sig.sev)})
sev.P <- reactive({ dsev(sev.t(), input$mu.sev, input$sig.sev)})
sev.R <- reactive({ 1-sev.C()})
sev.h <- reactive({ exp(log(sev.P())-log(sev.R()))})
sev.H <- reactive({ -1*log(1-psev(sev.t(), input$mu.sev, input$sig.sev))})
sev.Q <- reactive({ qsev(sev.p, input$mu.sev, input$sig.sev)})
sev.df <- reactive({data.frame(Time  = sev.t(),
                               PROB  = sev.p, 
                               CDF   = sev.C(),
                               PDF   = sev.P(),
                               REL   = sev.R(),
                               haz   = sev.h(),
                               HAZ   = sev.H(), 
                               QUANT = sev.Q())})

  output$sevC <- renderMetricsgraphics({
  mjs_plot(sev.df(), x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'F(t)')%>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")}) 
  
  output$sevP <- renderMetricsgraphics({
  mjs_plot(sev.df(), x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'f(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$sevR <- renderMetricsgraphics({
  mjs_plot(sev.df(), x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'S(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$sevh <- renderMetricsgraphics({
  mjs_plot(sev.df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'h(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$sevH <- renderMetricsgraphics({
  mjs_plot(sev.df(), x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'H(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$sevQ <- renderMetricsgraphics({
  mjs_plot(sev.df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Probability (p)', y_label = 't(p)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
}