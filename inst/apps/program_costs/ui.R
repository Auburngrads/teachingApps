ui = navbarPage(title = 'Program Costs',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),

      
     tabPanel('Visualization',
      #headerPanel('Visualizing the Distribution of Operating Costs'), 
       sidebarLayout(
        sidebarPanel(
         sliderInput('threshold', 
                     label = 'Cost Threshold',
                     min = 10000,
                     max = 60000,
                     value = 35000,
                     step = 1000),
         sliderInput('nsamples', 
                     label = 'Number of Samples',
                     min = 1000,
                     max = 50000,
                     value = 10000,
                     step = 1000),
         sliderInput('breaks', 
                     label = 'Number of Breaks',
                     min = 10,
                     max = 100,
                     value = 20,
                     step = 10),
         sliderInput('seed', 
                     label = 'Seed Value',
                     min = 10,
                     max = 100,
                     value = 42,
                     step = 10)),
        
         mainPanel(plotOutput('buyer',height = '650px')))),

tabPanel('How To Use This App',

         mainPanel(withMathJax(uiOutput("howtohist", class = 'ta-text')))))
