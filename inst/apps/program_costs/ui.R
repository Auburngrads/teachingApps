ui = navbarPage(title = 'Program Costs',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_style(),
                footer = teachingApps::add_brand(),

      
     tabPanel(h4('Visualization'),
      #headerPanel('Visualizing the Distribution of Operating Costs'), 
       sidebarLayout(
        sidebarPanel(
         sliderInput('threshold', 
                     label = h2('Cost Threshold'),
                     min = 10000,
                     max = 60000,
                     value = 35000,
                     step = 1000),
         sliderInput('nsamples', 
                     label = h2('Number of Samples'),
                     min = 1000,
                     max = 50000,
                     value = 10000,
                     step = 1000),
         sliderInput('breaks', 
                     label = h2('Number of Breaks'),
                     min = 10,
                     max = 100,
                     value = 20,
                     step = 10),
         sliderInput('seed', 
                     label = h2('Seed Value'),
                     min = 10,
                     max = 100,
                     value = 42,
                     step = 10)),
        
         mainPanel(plotOutput('buyer',height = '650px')))),

tabPanel(h4('How To Use This App'),

         mainPanel(withMathJax(uiOutput("howtohist", class = 'shiny-text-output'), width = 12))))
