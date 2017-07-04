ui = navbarPage(title = 'Maximum Likelihood',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_css(),
                footer = teachingApps::add_logo(),

tabPanel('Background',
      fluidRow(uiOutput('mleback1'), class = 'shiny-text-output')),

tabPanel('Simple Example',  
         fluidRow(uiOutput('example1_1'), class = 'shiny-text-output'),
         fluidRow(teachingApps::add_ui('maximum_likelihood_1obs')),
         fluidRow(uiOutput('example1_2'), class = 'shiny-text-output'),
         fluidRow(teachingApps::add_ui('maximum_likelihood_2obs')),
         fluidRow(uiOutput('example1_3'), class = 'shiny-text-output')),

tabPanel('Silly Example',
      fluidRow(uiOutput('example2_1'), class = 'shiny-text-output'),
      fluidRow(teachingApps::add_ui('maximum_likelihood_graphical_exp')),
      fluidRow(uiOutput('example2_2'), class = 'shiny-text-output'),
      fluidRow(teachingApps::add_ui('maximum_likelihood_numerical_exp')),
      fluidRow(uiOutput('example2_3'), class = 'shiny-text-output'),
      fluidRow(teachingApps::add_ui('maximum_likelihood_numerical_other'))),

tabPanel("A Simulation",
      fluidRow(teachingApps::add_ui('maximum_likelihood_simulation'))),

tabPanel('Details',
      fluidRow(uiOutput('details'), class = 'shiny-text-output')))
