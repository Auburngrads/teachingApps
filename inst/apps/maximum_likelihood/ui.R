ui = navbarPage(title = 'Maximum Likelihood',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),

tabPanel('Background',
         uiOutput('mleback1', class = 'ta-text')),

tabPanel('Simple Example',  
         uiOutput('example1_1', class = 'ta-text'),
           add_ui('maximum_likelihood_1obs'),
         uiOutput('example1_2', class = 'ta-text'),
           add_ui('maximum_likelihood_2obs'),
         uiOutput('example1_3', class = 'ta-text')),

tabPanel('Silly Example',
         uiOutput('example2_1', class = 'ta-text'),
           add_ui('maximum_likelihood_graphical_exp'),
         uiOutput('example2_2', class = 'ta-text'),
           add_ui('maximum_likelihood_numerical_exp'),
         uiOutput('example2_3', class = 'ta-text'),
           add_ui('maximum_likelihood_numerical_other')),

tabPanel("A Simulation",
           add_ui('maximum_likelihood_simulation')),

tabPanel('Details',
         uiOutput('details', class = 'ta-text')))
