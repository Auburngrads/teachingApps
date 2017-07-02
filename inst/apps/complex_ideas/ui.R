ui = navbarPage(title = 'Complex Ideas',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_css(),
                footer = teachingApps::add_logo(),

                
tabPanel(h4("Conf. Intervals"),
         fluidRow(teachingApps::add_ui('confidence_intervals'))),

tabPanel(h4("CLT"),
         fluidRow(teachingApps::add_ui('central_limit'))),

tabPanel(h4("Prob Plots"),
         fluidRow(teachingApps::add_ui('probability_plotting'))),

tabPanel(h4("Weibull Distro"),
         fluidRow(teachingApps::add_ui('distribution_weibull'))),

tabPanel(h4("ML Estimation"),
         fluidRow(teachingApps::add_ui('maximum_likelihood'))),

tabPanel(h4('Dice Roll'),
         fluidRow(teachingApps::add_ui('dice_roll'))))