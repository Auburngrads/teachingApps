server = function(input, output, session) {

gam.t = reactive({ signif(seq(min(input$range.gamma), max(input$range.gamma), length = 500), digits = 4)})
gam.p <- signif(seq(0, 1, length = 500), digits = 4)
gam.C <- reactive({ pgamma(gam.t(), input$kappa, input$theta)})
gam.P <- reactive({ dgamma(gam.t(), input$kappa, input$theta)})
gam.R <- reactive({ 1-gam.C()})
gam.h <- reactive({ exp(log(gam.P())-log(gam.R()))})
gam.H <- reactive({ -1*log(1-pgamma(gam.t(), input$kappa, input$theta))})
gam.Q <- reactive({ qgamma(gam.p, input$kappa, input$theta)})
gam.df <- reactive({data.frame(Time =  gam.t(),
                               PROB =  gam.p, 
                               CDF =   gam.C(),
                               PDF =   gam.P(),
                               REL =   gam.R(),
                               haz =   gam.h(),
                               HAZ =   gam.H(), 
                               QUANT = gam.Q())})

  output$gammaC <- renderMetricsgraphics({
  mjs_plot(gam.df(), x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'F(t)')%>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")}) 
  
  output$gammaP <- renderMetricsgraphics({
  mjs_plot(gam.df(), x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'f(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$gammaR <- renderMetricsgraphics({
  mjs_plot(gam.df(), x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'S(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$gammah <- renderMetricsgraphics({
  mjs_plot(gam.df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'h(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$gammaH <- renderMetricsgraphics({
  mjs_plot(gam.df(), x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'H(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$gammaQ <- renderMetricsgraphics({
  mjs_plot(gam.df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Probability', y_label = 'q(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
}