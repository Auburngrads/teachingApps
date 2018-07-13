server = function(input, output, session) {

weibhaz <-function(x,sc, sh) {sh/sc*(x/sc)^(sh-1)}
  
weib.t = reactive({ signif(seq(min(input$range.w), max(input$range.w), length = 500), digits = 4)})
weib.p <- signif(seq(0, 1, length = 500), digits = 4) 
weib.C <- reactive({ pweibull(weib.t(), input$shape.w, input$scale.w)})
weib.P <- reactive({ dweibull(weib.t(), input$shape.w, input$scale.w)})
weib.R <- reactive({ 1-weib.C()})
weib.h <- reactive({ weibhaz(weib.t(), input$scale.w, input$shape.w)})
weib.H <- reactive({ -1*log(1-pweibull(weib.t(), input$shape.w, input$scale.w))})
weib.Q <- reactive({ qweibull(weib.p, input$shape.w, input$scale.w)})
weib.df <- reactive({data.frame(Time  = weib.t(),
                                PROB  = weib.p, 
                                CDF   = weib.C(),
                                PDF   = weib.P(),
                                REL   = weib.R(),
                                haz   = weib.h(),
                                HAZ   = weib.H(),
                                QUANT = weib.Q())})

  output$weibC <- renderMetricsgraphics({
  mjs_plot(weib.df(), x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'F(t)')%>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")}) 
  
  output$weibP <- renderMetricsgraphics({
  mjs_plot(weib.df(), x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'f(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$weibR <- renderMetricsgraphics({
  mjs_plot(weib.df(), x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'S(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$weibh <- renderMetricsgraphics({
  mjs_plot(weib.df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'h(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$weibH <- renderMetricsgraphics({
  mjs_plot(weib.df(), x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'H(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$weibQ <- renderMetricsgraphics({
  mjs_plot(weib.df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Probability (p)', y_label = 't(p)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
}