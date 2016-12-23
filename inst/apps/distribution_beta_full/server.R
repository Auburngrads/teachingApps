server = function(input, output, session) {
  
beta.t <- reactive({ signif(seq(0,1, length.out = 500), digits = 4) + input$loc.beta })
beta.p <- reactive({ signif(seq(0, 1, length = 500), digits = 4) })
beta.C <- reactive({ pbeta(beta.t(), input$shape1, input$shape2)})
beta.P <- reactive({ dbeta(beta.t(), input$shape1, input$shape2)})
beta.R <- reactive({ 1 - beta.C()})
beta.h <- reactive({ exp(log(beta.P())-log(beta.R()))})
beta.H <- reactive({ -1 * log(1 - pbeta(beta.t(),input$shape1, input$shape2))})
beta.Q <- reactive({ qbeta(beta.p(),input$shape1, input$shape2)})
beta.df <- reactive({ data.frame(Time = beta.t(), 
                             PROB = beta.p(), 
                             CDF = beta.C(), 
                             PMF = beta.P(), 
                             REL = beta.R(), 
                             haz = beta.h(), 
                             HAZ = beta.H(),
                             QUANT = beta.Q()
                             )})
 
output$betaC <- renderMetricsgraphics({
  mjs_plot(beta.df(), x = Time, y = CDF, decimals = 4, top = 0) %>% 
  mjs_line(area = TRUE)                              %>% 
  mjs_labs(x_label = "X = x", y_label = "F(x)")       %>% 
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$betaP <- renderMetricsgraphics({
  mjs_plot(beta.df(), x = Time, y = PMF, decimals = 4)         %>% 
  mjs_line(area = TRUE)                             %>%
  mjs_labs(x_label = "X = x", y_label = "f(x)")      %>% 
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$betaR <- renderMetricsgraphics({
  mjs_plot(beta.df(), x = Time, y = REL, decimals = 4)         %>% 
  mjs_line(area = TRUE)                             %>% 
  mjs_labs(x_label = "X = x", y_label = "S(x)")      %>% 
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$betah <- renderMetricsgraphics({
  mjs_plot(beta.df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE)  %>%
  mjs_labs(x_label = "X = x", y_label = "h(x)") %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$betaH <- renderMetricsgraphics({
  mjs_plot(beta.df(), x = Time, y = HAZ, decimals = 4) %>% 
  mjs_line(area = TRUE)  %>% 
  mjs_labs(x_label = "X = x", y_label = "H(x)") %>% 
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$betaQ <- renderMetricsgraphics({
  mjs_plot(beta.df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE)  %>%
  mjs_labs(x_label = "Probability (p)", y_label = "x(p)") %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$betafunc <- renderUI({ 
  withMathJax(HTML(includeMarkdown(paste(c(arg2$appDir,'beta-func.Rmd'),collapse = '/'))))
})
output$betaprops <- renderUI({
  HTML(includeMarkdown(paste(c(arg2$appDir,'beta-props.Rmd'), collapse = '/')))
}) 
}