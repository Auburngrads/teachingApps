server = function(input, output, session) {

nor.t <- reactive({ signif(seq(min(input$range.n), max(input$range.n), length = 500), digits = 4)})
nor.p <- signif(seq(0, 1, length = 500), digits = 4) 
nor.C <- reactive({ pnorm(nor.t(), input$mu.n, input$sig.n)})
nor.P <- reactive({ dnorm(nor.t(), input$mu.n, input$sig.n)})
nor.R <- reactive({ 1-nor.C()})
nor.h <- reactive({ exp(log(nor.P())-log(nor.R()))})
nor.H <- reactive({ -1*log(1-pnorm(nor.t(), input$mu.n, input$sig.n))})
nor.Q <- reactive({ qnorm(nor.p, input$mu.n, input$sig.n)})
nor.df <- reactive({data.frame(Time  = nor.t(),
                               PROB  = nor.p, 
                               CDF   = nor.C(),
                               PDF   = nor.P(),
                               REL   = nor.R(),
                               haz   = nor.h(),
                               HAZ   = nor.H(), 
                               QUANT = nor.Q())})

  output$norC <- renderMetricsgraphics({
  mjs_plot(nor.df(), x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'F(t)')%>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")}) 
  
  output$norP <- renderMetricsgraphics({
  mjs_plot(nor.df(), x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'f(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$norR <- renderMetricsgraphics({
  mjs_plot(nor.df(), x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'S(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$norh <- renderMetricsgraphics({
  mjs_plot(nor.df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'h(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$norH <- renderMetricsgraphics({
  mjs_plot(nor.df(), x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'H(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$norQ <- renderMetricsgraphics({
  mjs_plot(nor.df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Probability', y_label = 'q(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
}