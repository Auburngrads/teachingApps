library(teachingApps)
library('metricsgraphics')

ui = navbarPage(title = 'Exponential Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
                header = tags$head(includeCSS(getShinyOption("css"))),
                footer = HTML(teachingApps::teachingApp(getShinyOption("appName"))),

tabPanel(h4('Shiny App'),
sidebarLayout(
sidebarPanel(width = 3, 
  sliderInput("rangee", 
              label = h2("Range:"),
              min = 0, 
              max = 50, 
              value = c(0,20)),
  sliderInput("theta", 
              label = h2(HTML("Scale (&theta;)")),
              min = .5, 
              max = 10, 
              step = .5, 
              value = 1), 
  sliderInput("gamma", 
              label = h2(HTML("Location (&gamma;)")),
              min = 0, 
              max = 15, 
              step = 1, 
              value = 0),
  withMathJax(),
  actionButton('ecdf', HTML('<script type="math/tex">F(t)</script>'),width = '31%'),
  actionButton('epdf', HTML('<script type="math/tex">f(t)</script>'),width = '31%'),
  actionButton('esur', HTML('<script type="math/tex">S(t)</script>'),width = '31%'),
  hr(),
  actionButton('ehaz', HTML('<script type="math/tex">h(t)</script>'),width = '31%'),
  actionButton('eHAZ', HTML('<script type="math/tex">H(t)</script>'),width = '31%'),
  actionButton('equa', HTML('<script type="math/tex">t(p)</script>'),width = '31%')),

  mainPanel(width = 9,  metricsgraphicsOutput("expfuncs",height = "600px")))),

tabPanel(h4('Distribution Functions'),
         mainPanel(uiOutput('expfunc'), class = 'shiny-text-output', width = 12)),

tabPanel(h4('Distribution Properties'),
         mainPanel(uiOutput('expprops', class = 'shiny-text-output'), width = 12)))
