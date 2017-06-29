ui = navbarPage(title = 'Maximum Likelihood',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_style(),
                footer = teachingApps::add_stamp(),

tabPanel(h4('Background'),
         fluidRow(uiOutput('mleback1'), class = 'shiny-text-output')),

tabPanel(h4('Simple Example'),  
         fluidRow(uiOutput('example1_1'), class = 'shiny-text-output'),
         fluidRow(teachingApps::add_ui('likelihood_ace')),
         fluidRow(uiOutput('example1_2'), class = 'shiny-text-output'),
         fluidRow(teachingApps::add_ui('likelihood_ace2')),
         fluidRow(uiOutput('example1_3'), class = 'shiny-text-output')),

tabPanel(h4('Silly Example'),
         fluidRow(uiOutput('example2_1'), class = 'shiny-text-output'),
         fluidRow(teachingApps::add_ui('exp_mle')),
         fluidRow(uiOutput('example2_2'), class = 'shiny-text-output'),
         fluidRow(teachingApps::add_ui('exp_numerical')),
         fluidRow(uiOutput('example2_3'), class = 'shiny-text-output'),
         fluidRow(teachingApps::add_ui('soln_numerical2'))),

tabPanel(h4("A Simulation"),
         fluidRow(teachingApps:::add_ui('likelihood_simulation'))),

tabPanel(h4('Details'),
         fluidRow(uiOutput('details'), class = 'shiny-text-output')))
