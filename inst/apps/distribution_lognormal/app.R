library(pos = -1,  package = 'metricsgraphics')










  
load('args.Rdata')
shinyApp(options = list(height = "700px"),
           
ui = navbarPage(theme = shinythemes::shinytheme(theme = arg2$theme),
               try(includeCSS(system.file('css',
                                          'my-shiny.css', 
                                          package = 'teachingApps')), silent = TRUE),
tabPanel(h4('Shiny App'),
sidebarLayout(
sidebarPanel(width = 3,
  hr(),
  sliderInput("range.ln", 
              label = h2("Range:"),
              min = 0, 
              max = 50, 
              value = c(0,20)),
  hr(),
  sliderInput("mu.ln", 
              label = h2(HTML("Log[Mean] (ln[&mu;])")),
              min = 0, 
              max = 10, 
              step = 0.5, 
              value = 4, 
              animate = T),
  hr(),
  sliderInput("sig.ln", 
              label = h2(HTML("log[Std Dev] (ln[&sigma;])")),
              min = .5, 
              max = 10, 
              step = 0.5, 
              value = 1, 
              animate = T)),

mainPanel(width = 9,
 tabsetPanel(type = 'pills',
  tabPanel(h4('Distribution Function'),  metricsgraphicsOutput("lnorC",height = "600px")),
  tabPanel(h4('Density'),                metricsgraphicsOutput("lnorP",height = "600px")),
  tabPanel(h4('Survival'),               metricsgraphicsOutput("lnorR",height = "600px")),
  tabPanel(h4('Hazard'),                 metricsgraphicsOutput("lnorh",height = "600px")),
  tabPanel(h4('Cumulative Hazard'),      metricsgraphicsOutput("lnorH",height = "600px")),
  tabPanel(h4('Quantile'),               metricsgraphicsOutput("lnorQ",height = "600px"))))),

fixedPanel(htmlOutput('sign'),bottom = '9%', right = '50%', height = '30px')),

tabPanel(h4('Distribution Functions'),
         mainPanel(uiOutput('lognfunc'), width = 12)),

tabPanel(h4('Distribution Properties'),
         mainPanel(uiOutput('logprops', class = 'shiny-text-output'), width = 12))),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(basename(getwd())))})
  
t = reactive({ signif(seq(min(input$range.ln), max(input$range.ln), length = 500), digits = 4)})
p <- signif(seq(0, 1, length = 500), digits = 4) 
C <- reactive({ plnorm(t(), log(input$mu.ln), input$sig.ln)})
P <- reactive({ dlnorm(t(), log(input$mu.ln), input$sig.ln)})
R <- reactive({ 1-C()})
h <- reactive({ exp(log(P())-log(R()))})
H <- reactive({ -1*log(1-plnorm(t(), log(input$mu.ln), input$sig.ln))})
Q <- reactive({ qlnorm(p, log(input$mu.ln), input$sig.ln)})
df <- reactive({data.frame(Time = t(),PROB = p, CDF = C(),PDF = P(),REL = R(),haz = h(),HAZ = H(), QUANT = Q())})

  output$lnorC <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'F(t)')%>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")}) 
  
  output$lnorP <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'f(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$lnorR <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'S(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$lnorh <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'h(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$lnorH <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'H(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$lnorQ <- renderMetricsgraphics({
  mjs_plot(df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Probability (p)', y_label = 't(p)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})

output$lognfunc <- renderUI({ 
  withMathJax(HTML('<h3>Functional relationships for 
<script id="MathJax-Element-31" type="math/tex">\\;T \\sim LOGNOR(\\mu,\\sigma),\\;\\;T \\in [0,\\infty)</script>
</h3>
$$
\\begin{aligned}
f(t|\\mu,\\sigma)&=\\frac{1}{\\sigma}\\phi_{nor}\\left(\\frac{\\log(t)-\\mu}{\\sigma}\\right)\\\\\\\\
F(t|\\mu,\\sigma)&=\\Phi_{nor}\\left(\\frac{\\log(t)-\\mu}{\\sigma}\\right)\\\\\\\\
h(t|\\mu,\\sigma)&=\\frac{f(t|\\mu,\\sigma)}{1-F(t|\\mu,\\sigma)}\\\\\\\\
t_{p}&=\\exp\\left[\\mu+\\Phi^{-1}_{nor}(p)\\sigma\\right], \\quad \\text{where}\\;\\Phi^{-1}_{nor}(p)=z_p\\\\\\\\
E[T]&=\\exp(\\mu+0.5\\sigma^2)\\\\\\\\
Var[T]&=\\exp(2\\mu+\\sigma^2)(\\exp(\\sigma^2)-1)
\\end{aligned}
$$
'))
})
output$logprops <- renderUI({HTML('<h3>About the Lognormal Distribution</h3>
<ul>
<li><p>Is the continuous counterpart to the geometric distribution</p></li>
<li><p>Describes the inter-arrival time durations between events in a homogeneous Poisson process</p></li>
<li><p>Is used to model the "useful-life" region of the bathtub curve</p></li>
<li><p>Implies that failures are due to random events or chance</p></li>
<li><p>Is a "memoryless" distribution</p></li>
<li><p>Is one of the most commonly used lifetime distributions in reliability analyses</p></li>
<li><p>Is the simplest distribution used in the analysis of reliability data</p></li>
<li><p>In real world scenarios, assuming exponentially distributed failure times is rarely valid</p></li>
</ul>')
})
})
