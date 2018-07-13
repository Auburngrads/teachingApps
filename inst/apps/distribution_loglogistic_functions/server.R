server = function(input, output, session) {
  
llog.t = reactive({ signif(seq(min(input$range.ll), max(input$range.ll), length = 500), digits = 4)})
llog.p <- signif(seq(0, 1, length = 500), digits = 4) 
llog.C <- reactive({ pllogis(llog.t(), input$mu.ll, input$sig.ll)})
llog.P <- reactive({ dllogis(llog.t(), input$mu.ll, input$sig.ll)})
llog.R <- reactive({ 1-llog.C()})
llog.h <- reactive({ exp(log(llog.P())-log(llog.R()))})
llog.H <- reactive({ -1*log(1-pllogis(llog.t(), input$mu.ll, input$sig.ll))})
llog.Q <- reactive({ qllogis(llog.p, input$mu.ll, input$sig.ll)})
llog.df <- reactive({data.frame(Time  = llog.t(),
                                PROB  = llog.p, 
                                CDF   = llog.C(),
                                PDF   = llog.P(),
                                REL   = llog.R(),
                                haz   = llog.h(),
                                HAZ   = llog.H(),
                                QUANT = llog.Q())})

  output$llogC <- renderMetricsgraphics({
  mjs_plot(llog.df(), x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'F(t)')%>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")}) 
  
  output$llogP <- renderMetricsgraphics({
  mjs_plot(llog.df(), x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'f(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$llogR <- renderMetricsgraphics({
  mjs_plot(llog.df(), x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'S(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$llogh <- renderMetricsgraphics({
  mjs_plot(llog.df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'h(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$llogH <- renderMetricsgraphics({
  mjs_plot(llog.df(), x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'H(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$llogQ <- renderMetricsgraphics({
  mjs_plot(llog.df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Probability (p)', y_label = 't(p)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
}