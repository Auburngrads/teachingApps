server = function(input, output, session) {

output$overview <- renderUI({ 
  withMathJax(HTML(includeMarkdown('background.Rmd')))
})
######################
# Exponential Server #
######################
output$expfunc <- renderUI({ 
  withMathJax(HTML(includeMarkdown(system.file('apps','distribution_exponential_full','exp-func.Rmd', package = 'teachingApps'))))
})
output$expprops <- renderUI({
  HTML(includeMarkdown(system.file('apps','distribution_exponential_full','exp-props.Rmd', package = 'teachingApps')))
})

exp.t = reactive({ signif(seq(min(input$rangee), max(input$rangee), length = 500), digits = 4)})
exp.p <- signif(seq(0, 1, length = 500), digits = 4)
exp.C <- reactive({ pexp(exp.t() - input$gamma, 1/input$theta)})
exp.P <- reactive({ dexp(exp.t() - input$gamma, 1/input$theta)})
exp.R <- reactive({ 1-exp.C()})
exp.h <- reactive({ 1/input$theta })
exp.H <- reactive({ -1*log(1-pexp(exp.t() - input$gamma, 1/input$theta))})
exp.Q <- reactive({ input$gamma-log(1-exp.p)*input$theta})
exp.df <- reactive({data.frame(Time = exp.t(),PROB = exp.p, CDF = exp.C(),PDF = exp.P(),REL = exp.R(),haz = exp.h(),HAZ = exp.H(), QUANT = exp.Q())})

output$expC <- renderMetricsgraphics({
  mjs_plot(exp.df(), x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'F(t)')%>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")}) 
  
  output$expP <- renderMetricsgraphics({
  mjs_plot(exp.df(), x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'f(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$expR <- renderMetricsgraphics({
  mjs_plot(exp.df(), x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'S(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$exph <- renderMetricsgraphics({
  mjs_plot(exp.df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'h(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$expH <- renderMetricsgraphics({
  mjs_plot(exp.df(), x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'H(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$expQ <- renderMetricsgraphics({
  mjs_plot(exp.df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Probability (p)', y_label = 't(p)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
#################
# Normal Server #
#################
output$norfunc <- renderUI({
  withMathJax(HTML(includeMarkdown(try(appFile('distribution_normal_full','nor-func.Rmd'), silent = T))))
})
output$norprops <- renderUI({
  HTML(includeMarkdown(system.file('apps','distribution_normal_full','nor-props.Rmd', package = 'teachingApps')))
})

nor.t <- reactive({ signif(seq(min(input$range.n), max(input$range.n), length = 500), digits = 4)})
nor.p <- signif(seq(0, 1, length = 500), digits = 4)
nor.C <- reactive({ pnorm(nor.t(), input$mu.n, input$sig.n)})
nor.P <- reactive({ dnorm(nor.t(), input$mu.n, input$sig.n)})
nor.R <- reactive({ 1-nor.C()})
nor.h <- reactive({ exp(log(nor.P())-log(nor.R()))})
nor.H <- reactive({ -1*log(1-pnorm(nor.t(), input$mu.n, input$sig.n))})
nor.Q <- reactive({ qnorm(nor.p, input$mu.n, input$sig.n)})
nor.df <- reactive({data.frame(Time = nor.t(),PROB = nor.p, CDF = nor.C(),PDF = nor.P(),REL = nor.R(),haz = nor.h(),HAZ = nor.H(), QUANT = nor.Q())})

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
##############
# SEV Server #
##############
output$sevfunc <- renderUI({
  withMathJax(HTML(includeMarkdown(system.file('apps','distribution_sev_full','sev-func.Rmd', package = 'teachingApps'))))
})
output$sevprops <- renderUI({
  HTML(includeMarkdown(system.file('apps','distribution_sev_full','sev-props.Rmd', package = 'teachingApps')))
})

sev.t = reactive({ signif(seq(min(input$range.s), max(input$range.s), length = 500), digits = 4)})
sev.p <- signif(seq(0, 1, length = 500), digits = 4)
sev.C <- reactive({ psev(sev.t(), input$mu.sev, input$sig.sev)})
sev.P <- reactive({ dsev(sev.t(), input$mu.sev, input$sig.sev)})
sev.R <- reactive({ 1-sev.C()})
sev.h <- reactive({ exp(log(sev.P())-log(sev.R()))})
sev.H <- reactive({ -1*log(1-psev(sev.t(), input$mu.sev, input$sig.sev))})
sev.Q <- reactive({ qsev(sev.p, input$mu.sev, input$sig.sev)})
sev.df <- reactive({data.frame(Time = sev.t(),PROB = sev.p, CDF = sev.C(),PDF = sev.P(),REL = sev.R(),haz = sev.h(),HAZ = sev.H(),QUANT = sev.Q())})

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
##############
# LEV Server #
##############
output$levfunc <- renderUI({
  withMathJax(HTML(includeMarkdown(system.file('apps','distribution_lev_full','lev-func.Rmd', package = 'teachingApps'))))
})
output$levprops <- renderUI({
  HTML(includeMarkdown(system.file('apps','distribution_lev_full','lev-props.Rmd', package = 'teachingApps')))
})

lev.t = reactive({ signif(seq(min(input$range.lev), max(input$range.lev), length = 500), digits = 4)})
lev.p <- signif(seq(0, 1, length = 500), digits = 4)
lev.C <- reactive({ plev(lev.t(), input$mu.lev, input$sig.lev)})
lev.P <- reactive({ dlev(lev.t(), input$mu.lev, input$sig.lev)})
lev.R <- reactive({ 1-lev.C()})
lev.h <- reactive({ exp(log(lev.P())-log(lev.R()))})
lev.H <- reactive({ -1*log(1-plev(lev.t(), input$mu.lev, input$sig.lev))})
lev.Q <- reactive({ qlev(lev.p, input$mu.lev, input$sig.lev)})
lev.df <- reactive({data.frame(Time = lev.t(),PROB = lev.p, CDF = lev.C(),PDF = lev.P(),REL = lev.R(),haz = lev.h(),HAZ = lev.H(),QUANT = lev.Q())})

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
###################
# Logistic Server #
###################
output$logisfunc <- renderUI({
  withMathJax(HTML(includeMarkdown(system.file('apps','distribution_logistic_full','log-func.Rmd', package = 'teachingApps'))))
})
output$logisprops <- renderUI({
  HTML(includeMarkdown(system.file('apps','distribution_logistic_full','log-props.Rmd', package = 'teachingApps')))
})

logis.t = reactive({ signif(seq(min(input$range.l), max(input$range.l), length = 500), digits = 4)})
logis.p <- signif(seq(0, 1, length = 500), digits = 4) 
logis.C <- reactive({ plogis(logis.t(), input$mu.l, input$sig.l)})
logis.P <- reactive({ dlogis(logis.t(), input$mu.l, input$sig.l)})
logis.R <- reactive({ 1-logis.C()})
logis.h <- reactive({ exp(log(logis.P())-log(logis.R()))})
logis.H <- reactive({ -1*log(1-plogis(logis.t(), input$mu.l, input$sig.l))})
logis.Q <- reactive({ qlogis(logis.p, input$mu.l, input$sig.l)})
logis.df <- reactive({data.frame(Time = logis.t(),PROB = logis.p, CDF = logis.C(),PDF = logis.P(),REL = logis.R(),haz = logis.h(),HAZ = logis.H(), QUANT = logis.Q())})

  output$logC <- renderMetricsgraphics({
  mjs_plot(logis.df(), x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'F(t)')%>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")}) 
  
  output$logP <- renderMetricsgraphics({
  mjs_plot(logis.df(), x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'f(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$logR <- renderMetricsgraphics({
  mjs_plot(logis.df(), x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'S(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$logh <- renderMetricsgraphics({
  mjs_plot(logis.df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'h(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$logH <- renderMetricsgraphics({
  mjs_plot(logis.df(), x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'H(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$logQ <- renderMetricsgraphics({
  mjs_plot(logis.df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Probability (p)', y_label = 't(p)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
}