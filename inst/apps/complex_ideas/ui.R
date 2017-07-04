ui = navbarPage(title = 'Complex Ideas',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_css(),
                footer = teachingApps::add_logo(),

                
tabPanel("Conf. Intervals",
      fluidRow(teachingApps::add_ui('confidence_intervals'))),

tabPanel("CLT",
      fluidRow(teachingApps::add_ui('central_limit'))),

tabPanel("Prob Plots",
      fluidRow(teachingApps::add_ui('probability_plotting'))),

tabPanel("Weibull Distro",
      fluidRow(teachingApps::add_ui('distribution_weibull'))),

tabPanel("ML Estimation",
      fluidRow(teachingApps::add_ui('maximum_likelihood'))),

tabPanel('Dice Roll',
      fluidRow(teachingApps::add_ui('dice_roll'))))