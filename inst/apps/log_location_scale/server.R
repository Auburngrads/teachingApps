server = function(input, output, session) {

output$overview <- renderUI({ 
  withMathJax(HTML(includeMarkdown('background.Rmd')))
})

######################
# Lognormal Server #
######################
output$lnorfunc <- renderUI({ 
  withMathJax(HTML(includeMarkdown(system.file('apps','distribution_lognormal_full','lnor-func.Rmd', package = 'teachingApps'))))
})
output$lnorprops <- renderUI({
  HTML(includeMarkdown(system.file('apps','distribution_lognormal_full','lnor-props.Rmd', package = 'teachingApps')))
})

ln.t = reactive({ signif(seq(min(input$range.ln), max(input$range.ln), length = 500), digits = 4)})
ln.p <- signif(seq(0, 1, length = 500), digits = 4) 
ln.C <- reactive({ plnorm(ln.t(), log(input$mu.ln), input$sig.ln)})
ln.P <- reactive({ dlnorm(ln.t(), log(input$mu.ln), input$sig.ln)})
ln.R <- reactive({ 1-ln.C()})
ln.h <- reactive({ exp(log(ln.P())-log(ln.R()))})
ln.H <- reactive({ -1*log(1-plnorm(ln.t(), log(input$mu.ln), input$sig.ln))})
ln.Q <- reactive({ qlnorm(ln.p, log(input$mu.ln), input$sig.ln)})
ln.df <- reactive({data.frame(Time = ln.t(),PROB = ln.p, CDF = ln.C(),PDF = ln.P(),REL = ln.R(),haz = ln.h(),HAZ = ln.H(), QUANT = ln.Q())})

  output$lnorC <- renderMetricsgraphics({
  mjs_plot(ln.df(), x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'F(t)')%>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")}) 
  
  output$lnorP <- renderMetricsgraphics({
  mjs_plot(ln.df(), x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'f(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$lnorR <- renderMetricsgraphics({
  mjs_plot(ln.df(), x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'S(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$lnorh <- renderMetricsgraphics({
  mjs_plot(ln.df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'h(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$lnorH <- renderMetricsgraphics({
  mjs_plot(ln.df(), x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'H(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$lnorQ <- renderMetricsgraphics({
  mjs_plot(ln.df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Probability (p)', y_label = 't(p)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
######################
# Weibull Server #
######################
output$weibfunc <- renderUI({ 
  withMathJax(HTML(includeMarkdown(system.file('apps','distribution_weibull_full','weib-func.Rmd', package = 'teachingApps'))))
})
output$weibprops <- renderUI({
  HTML(includeMarkdown(system.file('apps','distribution_weibull_full','weib-props.Rmd', package = 'teachingApps')))
})

weibhaz <-function(x,sc, sh) {sh/sc*(x/sc)^(sh-1)}

weib.t = reactive({ signif(seq(min(input$range.w), max(input$range.w), length = 500), digits = 4)})
weib.p <- signif(seq(0, 1, length = 500), digits = 4) 
weib.C <- reactive({ pweibull(weib.t(), input$shape.w, input$scale.w)})
weib.P <- reactive({ dweibull(weib.t(), input$shape.w, input$scale.w)})
weib.R <- reactive({ 1-weib.C()})
weib.h <- reactive({ weibhaz(weib.t(), input$scale.w, input$shape.w)})
weib.H <- reactive({ -1*log(1-pweibull(weib.t(), input$shape.w, input$scale.w))})
weib.Q <- reactive({ qweibull(weib.p, input$shape.w, input$scale.w)})
weib.df <- reactive({data.frame(Time = weib.t(),PROB = weib.p, CDF = weib.C(),PDF = weib.P(),REL = weib.R(),haz = weib.h(),HAZ = weib.H(), QUANT = weib.Q())})

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

######################
# Loglogistic Server #
######################
output$llogisfunc <- renderUI({ 
  withMathJax(HTML(includeMarkdown(system.file('apps','distribution_loglogistic_full','llog-func.Rmd', package = 'teachingApps'))))
})
output$llogisprops <- renderUI({
  HTML(includeMarkdown(system.file('apps','distribution_loglogistic_full','llog-props.Rmd', package = 'teachingApps')))
})
ll.t = reactive({ signif(seq(min(input$range.ll), max(input$range.ll), length = 500), digits = 4)})
ll.p <- signif(seq(0, 1, length = 500), digits = 4) 
ll.C <- reactive({ pllogis(ll.t(), input$mu.ll, input$sig.ll)})
ll.P <- reactive({ dllogis(ll.t(), input$mu.ll, input$sig.ll)})
ll.R <- reactive({ 1-ll.C()})
ll.h <- reactive({ exp(log(ll.P())-log(ll.R()))})
ll.H <- reactive({ -1*log(1-pllogis(ll.t(), input$mu.ll, input$sig.ll))})
ll.Q <- reactive({ qllogis(ll.p, input$mu.ll, input$sig.ll)})
ll.df <- reactive({data.frame(Time = ll.t(),PROB = ll.p, CDF = ll.C(),PDF = ll.P(),REL = ll.R(),haz = ll.h(),HAZ = ll.H(), QUANT = ll.Q())})

  output$llogC <- renderMetricsgraphics({
  mjs_plot(ll.df(), x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'F(t)')%>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")}) 
  
  output$llogP <- renderMetricsgraphics({
  mjs_plot(ll.df(), x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'f(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$llogR <- renderMetricsgraphics({
  mjs_plot(ll.df(), x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'S(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$llogh <- renderMetricsgraphics({
  mjs_plot(ll.df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'h(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$llogH <- renderMetricsgraphics({
  mjs_plot(ll.df(), x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'H(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$llogQ <- renderMetricsgraphics({
  mjs_plot(ll.df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Probability (p)', y_label = 't(p)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
}