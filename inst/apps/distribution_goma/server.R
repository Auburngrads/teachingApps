server = function(input, output, session) {

goma.t <-  reactive({ signif(seq(input$rangegoma[1], input$rangegoma[2],length = 500),digits = 4)})
goma.p <-  reactive({ signif(seq(0.001, .999, length = 500), digits = 4) })
goma.C <-  reactive({ pgoma(goma.t(), input$th.goma, input$ze.goma, input$et.goma)})
goma.P <-  reactive({ dgoma(goma.t(), input$th.goma, input$ze.goma, input$et.goma)})
goma.R <-  reactive({ 1-goma.C()})
goma.h <-  reactive({ exp(log(goma.P())-log(goma.R()))})
goma.H <-  reactive({-1*log(1-pgoma(goma.t(), input$th.goma,input$ze.goma,input$et.goma))})
goma.Q <-  reactive({ qgoma(goma.p(), input$th.goma,input$ze.goma,input$et.goma)})
goma.df <- reactive({data.frame(Time  = goma.t(),
                                PROB  = goma.p(),
                                CDF   = goma.C(),
                                PDF   = goma.P(),
                                REL   = goma.R(),
                                haz   = goma.h(),
                                HAZ   = goma.H(),
                                QUANT = goma.Q())})

  output$gomaC <- renderMetricsgraphics({
  mjs_plot(goma.df(), x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'F(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")}) 
  
  output$gomaP <- renderMetricsgraphics({
  mjs_plot(goma.df(), x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'f(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$gomaR <- renderMetricsgraphics({
  mjs_plot(goma.df(), x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'S(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$gomah <- renderMetricsgraphics({
  mjs_plot(goma.df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'h(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$gomaH <- renderMetricsgraphics({
  mjs_plot(goma.df(), x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'H(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$gomaQ <- renderMetricsgraphics({
  mjs_plot(goma.df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Probability (p)', y_label = 't(p)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
}