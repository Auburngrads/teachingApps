ui = navbarPage(title = 'Probability Functions',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),


tabPanel('Overview',
         uiOutput('overview', class = 'ta-text')),

tabPanel('Relationship Table',
         uiOutput('functable', class = 'ta-text')),
                
navbarMenu('The Functions', icon = icon('folder-open'),
           
tabPanel('Cumulative Distribution Function', 
tabsetPanel(type = 'pills',
                                
  tabPanel('Properties of the CDF',
           uiOutput('cdfdemo', class = 'ta-text')),

  tabPanel('Computing Values in R',
           uiOutput('cdfr', class = 'ta-text')),
                                
  tabPanel('Interactive Shiny App',
           add_ui('cdf_ace')))),

tabPanel('Probability Density Function', 
        tabsetPanel(type = 'pills',

  tabPanel('Properties',
           uiOutput('pdfdemo', class = 'ta-text')),

  tabPanel('Computing Values in R',
           uiOutput('pdfr', class = 'ta-text')),
  
  tabPanel('Interactive Shiny App',
           add_ui('pdf_ace')))),

tabPanel('Survival (Reliability) Function', 
tabsetPanel(type = 'pills',
                                
  tabPanel('Properties of the Survival Function',
           uiOutput('reldemo', class = 'ta-text')),

  tabPanel('Computing Values in R',
           uiOutput('relr', class = 'ta-text')),
                                
  tabPanel('Interactive Shiny App',
           add_ui('rel_ace')))),

tabPanel('Hazard Function', 
tabsetPanel(type = 'pills',
                                
  tabPanel('Properties of the Hazard Function',
           uiOutput('hazdemo', class = 'ta-text')),

  tabPanel('Computing Values in R',
           uiOutput('hazr', class = 'ta-text')),
                                
  tabPanel('Interactive Shiny App',
           add_ui('haz_ace')))),

tabPanel('Cumulative Hazard Function', 
tabsetPanel(type = 'pills',
                                
  tabPanel('Properties of the Cumulative Hazard Function',
           uiOutput('chazdemo', class = 'ta-text')),

  tabPanel('Computing Values in R',
           uiOutput('chazr', class = 'ta-text')),
                                
  tabPanel('Interactive Shiny App',
           add_ui('chaz_ace')))),


tabPanel('Quantile Function', 
tabsetPanel(type = 'pills',
                                
  tabPanel('Properties of the Quantile Function',
           uiOutput('quandemo', class = 'ta-text')),

  tabPanel('Computing Values in R',
           uiOutput('quanr', class = 'ta-text')),
                                
  tabPanel('Interactive Shiny App',
           add_ui('quan_ace'))))))
