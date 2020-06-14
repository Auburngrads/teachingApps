server = function(input, output, session) {
  
egeng.t <- reactive({ signif(seq(input$range.egeng[1], input$range.egeng[2], length = 500), digits = 4)})
egeng.p <- signif(seq(0, 1, length = 500), digits = 4) 
egeng.C <- reactive({ teachingApps:::pegengl(egeng.t(), input$mu.egeng, input$sig.egeng, input$lam.egeng)})
egeng.P <- reactive({ teachingApps:::degengl(egeng.t(), input$mu.egeng, input$sig.egeng, input$lam.egeng)})
egeng.R <- reactive({ 1-egeng.C()})
egeng.h <- reactive({ exp(log(egeng.P())-log(egeng.R()))})
egeng.H <- reactive({ -1*log(1-teachingApps:::pegengl(egeng.t(), input$mu.egeng, input$sig.egeng, input$lam.egeng))})
egeng.Q <- reactive({ teachingApps:::qegengl(egeng.p, input$mu.egeng, input$sig.egeng, input$lam.egeng)})
egeng.df <- reactive({data.frame(Time  = egeng.t(),
                                 PROB  = egeng.p, 
                                 CDF   = egeng.C(),
                                 PDF   = egeng.P(),
                                 REL   = egeng.R(),
                                 haz   = egeng.h(),
                                 HAZ   = egeng.H(), 
                                 QUANT = egeng.Q())})

  output$egengC <- renderMetricsgraphics({
  mjs_plot(egeng.df(), x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'F(t)')%>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")}) 
  
  output$egengP <- renderMetricsgraphics({
  mjs_plot(egeng.df(), x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'f(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$egengR <- renderMetricsgraphics({
  mjs_plot(egeng.df(), x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'S(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$egengh <- renderMetricsgraphics({
  mjs_plot(egeng.df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'h(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$egengH <- renderMetricsgraphics({
  mjs_plot(egeng.df(), x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'H(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$egengQ <- renderMetricsgraphics({
  mjs_plot(egeng.df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Probability (p)', y_label = 't(p)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
}