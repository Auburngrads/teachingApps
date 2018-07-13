server = function(input, output, session) {
  
lev.t = reactive({ signif(seq(min(input$range.lev), max(input$range.lev), length = 500), digits = 4)})
lev.p <- signif(seq(0, 1, length = 500), digits = 4) 
lev.C <- reactive({ plev(lev.t(), input$mu.lev, input$sig.lev)})
lev.P <- reactive({ dlev(lev.t(), input$mu.lev, input$sig.lev)})
lev.R <- reactive({ 1-lev.C()})
lev.h <- reactive({ exp(log(lev.P())-log(lev.R()))})
lev.H <- reactive({ -1*log(1-plev(lev.t(), input$mu.lev, input$sig.lev))})
lev.Q <- reactive({ qlev(lev.p, input$mu.lev, input$sig.lev)})
lev.df <- reactive({data.frame(Time  = lev.t(),
                               PROB  = lev.p, 
                               CDF   = lev.C(),
                               PDF   = lev.P(),
                               REL   = lev.R(),
                               haz   = lev.h(),
                               HAZ   = lev.H(), 
                               QUANT = lev.Q())})

  output$levC <- renderMetricsgraphics({
  mjs_plot(lev.df(), x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'F(t)')%>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")}) 
  
  output$levP <- renderMetricsgraphics({
  mjs_plot(lev.df(), x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'f(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$levR <- renderMetricsgraphics({
  mjs_plot(lev.df(), x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'S(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$levh <- renderMetricsgraphics({
  mjs_plot(lev.df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'h(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$levH <- renderMetricsgraphics({
  mjs_plot(lev.df(), x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'H(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$levQ <- renderMetricsgraphics({
  mjs_plot(lev.df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Probability (p)', y_label = 't(p)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
}