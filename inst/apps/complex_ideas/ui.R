ui = navbarPage(title = 'Complex Ideas',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_style(),
                footer = teachingApps::add_brand(),

                
tabPanel(h4("Conf. Intervals"),
         fluidRow(teachingApps::nestUI('confidence_intervals'))),

tabPanel(h4("CLT"),
         fluidRow(teachingApps::nestUI('central_limit'))),

tabPanel(h4("Prob Plots"),
         fluidRow(teachingApps::nestUI('probability_plotting'))),

tabPanel(h4("Weibull Distro"),
         fluidRow(teachingApps::nestUI('distribution_weibull'))),

tabPanel(h4("ML Estimation"),
         fluidRow(teachingApps::nestUI('maximum_likelihood'))),

tabPanel(h4('Dice Roll'),
         fluidRow(teachingApps::nestUI('dice_roll'))))