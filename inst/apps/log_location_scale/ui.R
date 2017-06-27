ui = navbarPage(title = 'Log-Location-Scale Family',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_style(),
                footer = teachingApps::add_brand(),


tabPanel(h4('Overview'),
         mainPanel(uiOutput('overview'), 
                   class = 'shiny-text-output', 
                   width = 12)),
##########################
tabPanel(h4('Lognormal'),
##########################
fluidRow(
  column(width = 12,
     mainPanel(uiOutput('lnorfunc'),
                     class = 'shiny-text-output', width = '100%'))),

fluidRow(
  column(width = 12,
     mainPanel(uiOutput('lnorprops'),
                     class = 'shiny-text-output', width = '100%'))),

fluidRow(
  column(width = 12, h3('Interactive Shiny App'))),

fluidRow(
  column(width = 3,
  sidebarPanel(width = '100%',
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
              animate = T))),

column(width = 9,
    mainPanel(width = '100%',
 tabsetPanel(type = 'pills',
  tabPanel(h4(HTML('CDF <script type="math/tex">F(t)</script>')),  
           metricsgraphicsOutput("lnorC",height = "600px")),
  tabPanel(h4(HTML('PDF <script type="math/tex">f(t)</script>')),                
           metricsgraphicsOutput("lnorP",height = "600px")),
  tabPanel(h4(HTML('Survival <script type="math/tex">S(t)</script>')),
           metricsgraphicsOutput("lnorR",height = "600px")),
  tabPanel(h4(HTML('Hazard <script type="math/tex">h(t)</script>')),
           metricsgraphicsOutput("lnorh",height = "600px")),
  tabPanel(h4(HTML('Cum Hazard <script type="math/tex">H(t)</script>')),
           metricsgraphicsOutput("lnorH",height = "600px")),
  tabPanel(h4(HTML('Quantile <script type="math/tex">F^{-1}(p)</script>')),
           metricsgraphicsOutput("lnorQ",height = "600px"))))))),

##########################
tabPanel(h4('Weibull'),
##########################
fluidRow(
  column(width = 12,
     mainPanel(uiOutput('weibfunc'),
                     class = 'shiny-text-output', width = '100%'))),

fluidRow(
  column(width = 12,
     mainPanel(uiOutput('weibprops'),
                     class = 'shiny-text-output', width = '100%'))),

fluidRow(
  column(width = 12, h3('Interactive Shiny App'))),

fluidRow(
  column(width = 3,
  sidebarPanel(width = '100%',
  sliderInput("range.w", 
              label = h2("Range"),  
              min = 0, 
              max = 50, 
              value = c(0,25)),
  hr(),
  sliderInput("scale.w", 
              label = h2(HTML("Scale (&eta;)")),  
              min = 5, 
              max = 30, 
              step = 1, 
              value = 10, 
              animate = T),
  hr(),
  sliderInput("shape.w", 
              label = h2(HTML("Shape (&beta;)")),  
              min = .5, 
              max = 10, 
              step = .5, 
              value = .5, 
              animate = T))),

column(width = 9,
    mainPanel(width = '100%',
 tabsetPanel(type = 'pills',
  tabPanel(h4('Distribution Function'),  metricsgraphicsOutput("weibC",height = "600px")),
  tabPanel(h4('Density'),                metricsgraphicsOutput("weibP",height = "600px")),
  tabPanel(h4('Survival'),               metricsgraphicsOutput("weibR",height = "600px")),
  tabPanel(h4('Hazard'),                 metricsgraphicsOutput("weibh",height = "600px")),
  tabPanel(h4('Cumulative Hazard'),      metricsgraphicsOutput("weibH",height = "600px")),
  tabPanel(h4('Quantile'),               metricsgraphicsOutput("weibQ",height = "600px"))))))),

##########################
tabPanel(h4('Loglogistic'),
##########################
fluidRow(
  column(width = 12,
     mainPanel(uiOutput('llogisfunc'),
                     class = 'shiny-text-output', width = '100%'))),

fluidRow(
  column(width = 12,
     mainPanel(uiOutput('llogisprops'),
                     class = 'shiny-text-output', width = '100%'))),

fluidRow(
  column(width = 12, h3('Interactive Shiny App'))),

fluidRow(
  column(width = 3,
  sidebarPanel(width = '100%',
  sliderInput("range.ll", 
              label = h2("Range"),
              min = 0, 
              max = 50, 
              value = c(0,20)),
  hr(),
  sliderInput("mu.ll", 
              label = h2(HTML("Mean (&mu;)")),
              min = 0.5, 
              max = 10, 
              step = 0.5, 
              value = 0.5, 
              animate = T),
  hr(),
  sliderInput("sig.ll", 
              label = h2(HTML("Std Dev (&sigma;)")),
              min = 0.5, 
              max = 10, 
              step = 0.5, 
              value = 1, 
              animate = T))),

column(width = 9,
    mainPanel(width = '100%',
 tabsetPanel(type = 'pills',
  tabPanel(h4('Distribution Function'),  metricsgraphicsOutput("llogC",height = "600px")),
  tabPanel(h4('Density'),                metricsgraphicsOutput("llogP",height = "600px")),
  tabPanel(h4('Survival'),               metricsgraphicsOutput("llogR",height = "600px")),
  tabPanel(h4('Hazard'),                 metricsgraphicsOutput("llogh",height = "600px")),
  tabPanel(h4('Cumulative Hazard'),      metricsgraphicsOutput("llogH",height = "600px")),
  tabPanel(h4('Quantile'),               metricsgraphicsOutput("llogQ",height = "600px")))))))
)

