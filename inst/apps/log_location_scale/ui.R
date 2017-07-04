ui = navbarPage(title = 'Log-Location-Scale Family',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_css(),
                footer = teachingApps::add_logo(),


tabPanel('Overview',
         mainPanel(uiOutput('overview'), 
         class = 'ta-text', 
         width = 12)),
##########################
tabPanel('Lognormal',
##########################
fluidRow(
  column(width = 12,
     mainPanel(uiOutput('lnorfunc'),
               class = 'ta-text', width = '100%'))),

fluidRow(
  column(width = 12,
     mainPanel(uiOutput('lnorprops'),
               class = 'ta-text', width = '100%'))),

fluidRow(
  column(width = 12, 'Interactive Shiny App')),

fluidRow(
  column(width = 3,
  sidebarPanel(width = '100%',
  sliderInput("range.ln", 
              label = "Range:",
              min = 0, 
              max = 50, 
              value = c(0,20)),
  hr(),
  sliderInput("mu.ln", 
              label = HTML("Log[Mean] (ln[&mu;])"),
              min = 0, 
              max = 10, 
              step = 0.5, 
              value = 4, 
              animate = T),
  hr(),
  sliderInput("sig.ln", 
              label = HTML("log[Std Dev] (ln[&sigma;])"),
              min = .5, 
              max = 10, 
              step = 0.5, 
              value = 1, 
              animate = T))),

column(width = 9,
    mainPanel(width = '100%',
 tabsetPanel(type = 'pills',
  tabPanel(HTML('CDF <script type="math/tex">F(t)</script>'),  
           metricsgraphicsOutput("lnorC",height = "600px")),
  tabPanel(HTML('PDF <script type="math/tex">f(t)</script>'),                
           metricsgraphicsOutput("lnorP",height = "600px")),
  tabPanel(HTML('Survival <script type="math/tex">S(t)</script>'),
           metricsgraphicsOutput("lnorR",height = "600px")),
  tabPanel(HTML('Hazard <script type="math/tex">h(t)</script>'),
           metricsgraphicsOutput("lnorh",height = "600px")),
  tabPanel(HTML('Cum Hazard <script type="math/tex">H(t)</script>'),
           metricsgraphicsOutput("lnorH",height = "600px")),
  tabPanel(HTML('Quantile <script type="math/tex">F^{-1}(p)</script>'),
           metricsgraphicsOutput("lnorQ",height = "600px"))))))),

##########################
tabPanel('Weibull',
##########################
fluidRow(
  column(width = 12,
     mainPanel(uiOutput('weibfunc'),
               class = 'ta-text', width = '100%'))),

fluidRow(
  column(width = 12,
     mainPanel(uiOutput('weibprops'),
               class = 'ta-text', width = '100%'))),

fluidRow(
  column(width = 12, 'Interactive Shiny App')),

fluidRow(
  column(width = 3,
  sidebarPanel(width = '100%',
  sliderInput("range.w", 
              label = "Range",  
              min = 0, 
              max = 50, 
              value = c(0,25)),
  hr(),
  sliderInput("scale.w", 
              label = HTML("Scale (&eta;)"),  
              min = 5, 
              max = 30, 
              step = 1, 
              value = 10, 
              animate = T),
  hr(),
  sliderInput("shape.w", 
              label = HTML("Shape (&beta;)"),  
              min = .5, 
              max = 10, 
              step = .5, 
              value = .5, 
              animate = T))),

column(width = 9,
    mainPanel(width = '100%',
 tabsetPanel(type = 'pills',
  tabPanel('Distribution Function',
           metricsgraphicsOutput("weibC",height = "600px")),
  tabPanel('Density',
           metricsgraphicsOutput("weibP",height = "600px")),
  tabPanel('Survival',
           metricsgraphicsOutput("weibR",height = "600px")),
  tabPanel('Hazard',
           metricsgraphicsOutput("weibh",height = "600px")),
  tabPanel('Cumulative Hazard',
           metricsgraphicsOutput("weibH",height = "600px")),
  tabPanel('Quantile',
           metricsgraphicsOutput("weibQ",height = "600px"))))))),

##########################
tabPanel('Loglogistic',
##########################
fluidRow(
  column(width = 12,
     mainPanel(uiOutput('llogisfunc'),
               class = 'ta-text', width = '100%'))),

fluidRow(
  column(width = 12,
     mainPanel(uiOutput('llogisprops'),
               class = 'ta-text', width = '100%'))),

fluidRow(
  column(width = 12, 'Interactive Shiny App')),

fluidRow(
  column(width = 3,
  sidebarPanel(width = '100%',
  sliderInput("range.ll", 
              label = "Range",
              min = 0, 
              max = 50, 
              value = c(0,20)),
  hr(),
  sliderInput("mu.ll", 
              label = HTML("Mean (&mu;)"),
              min = 0.5, 
              max = 10, 
              step = 0.5, 
              value = 0.5, 
              animate = T),
  hr(),
  sliderInput("sig.ll", 
              label = HTML("Std Dev (&sigma;)"),
              min = 0.5, 
              max = 10, 
              step = 0.5, 
              value = 1, 
              animate = T))),

column(width = 9,
    mainPanel(width = '100%',
 tabsetPanel(type = 'pills',
  tabPanel('Distribution Function',
           metricsgraphicsOutput("llogC",height = "600px")),
  tabPanel('Density',
           metricsgraphicsOutput("llogP",height = "600px")),
  tabPanel('Survival',
           metricsgraphicsOutput("llogR",height = "600px")),
  tabPanel('Hazard',
           metricsgraphicsOutput("llogh",height = "600px")),
  tabPanel('Cumulative Hazard',
           metricsgraphicsOutput("llogH",height = "600px")),
  tabPanel('Quantile',
           metricsgraphicsOutput("llogQ",height = "600px"))))))))

