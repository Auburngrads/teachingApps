library(teachingApps)
library('metricsgraphics')

shinyApp(options = list(height = "850px"),


         
ui = navbarPage(title = 'Exponential Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
                header = tags$head(includeCSS(getShinyOption("css"))),
                footer = HTML(teachingApps::teachingApp(getShinyOption("appName"))),

tabPanel(h4('Shiny App'),
sidebarLayout(
sidebarPanel(width = 3, 
             hr(),
  sliderInput("rangee", 
              label = h2("Range:"),
              min = 0, 
              max = 50, 
              value = c(0,20)),
  hr(),
  sliderInput("theta", 
              label = h2(HTML("Scale (&theta;)")),
              min = .5, 
              max = 10, 
              step = .5, 
              value = 1, 
              animate = T),
  hr(),
  sliderInput("gamma", 
              label = h2(HTML("Location (&gamma;)")),
              min = 0, 
              max = 15, 
              step = 1, 
              value = 0, 
              animate = T)),

  mainPanel(width = 9,
 tabsetPanel(type = 'pills',
  tabPanel(h4('Distribution Function'),  metricsgraphicsOutput("expC",height = "600px")),
  tabPanel(h4('Density'),                metricsgraphicsOutput("expP",height = "600px")),
  tabPanel(h4('Survival'),               metricsgraphicsOutput("expR",height = "600px")),
  tabPanel(h4('Hazard'),                 metricsgraphicsOutput("exph",height = "600px")),
  tabPanel(h4('Cumulative Hazard'),      metricsgraphicsOutput("expH",height = "600px")),
  tabPanel(h4('Quantile'),               metricsgraphicsOutput("expQ",height = "600px")))))),

tabPanel(h4('Distribution Functions'),
         mainPanel(uiOutput('expfunc'), width = 12)),

tabPanel(h4('Distribution Properties'),
         mainPanel(uiOutput('expprops', class = 'shiny-text-output'), width = 12))),

server = function(input, output, session) {
  
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
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
}) 
output$expP <- renderMetricsgraphics({
  mjs_plot(exp.df(), x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'f(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$expR <- renderMetricsgraphics({
  mjs_plot(exp.df(), x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'S(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$exph <- renderMetricsgraphics({
  mjs_plot(exp.df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'h(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$expH <- renderMetricsgraphics({
  mjs_plot(exp.df(), x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'H(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$expQ <- renderMetricsgraphics({
  mjs_plot(exp.df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Probability (p)', y_label = 't(p)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$expfunc <- renderUI({ 
  withMathJax(HTML('<h3>Functional relationships for 
<script id="MathJax-Element-31" type="math/tex">\\;T \\sim EXP(\\theta,\\gamma),\\;\\;T \\in [0,\\infty)</script>
</h3>
$$
\\begin{aligned}
f(t|\\theta,\\gamma)&=\\frac{1}{\\theta}\\exp\\left(-\\frac{t-\\gamma}{\\theta}\\right)\\\\\\\\
F(t|\\theta,\\gamma)&=1-\\exp\\left(\\frac{t-\\gamma}{\\theta}\\right)\\\\\\\\
h(t|\\theta,\\gamma)&=\\frac{1}{\\theta}, t>\\gamma\\\\\\\\\
t_{p}&=\\gamma-\\log(1-p)\\theta\\\\\\\\
E[T]&=\\gamma+\\theta\\\\\\\\
Var[T]&=\\theta^2
\\end{aligned}
$$'))
})
output$expprops <- renderUI({HTML('<h3>About the Exponential Distribution</h3>
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
