ui = navbarPage(title = 'Complex Ideas',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),

                
tabPanel("Conf. Intervals",
      fluidRow(add_ui('confidence_intervals'))),

tabPanel("CLT",
      fluidRow(add_ui('central_limit'))),

tabPanel("Prob Plots",
      fluidRow(add_ui('probability_plotting'))),

tabPanel("Weibull Distro",
      fluidRow(add_ui('distribution_weibull'))),

tabPanel("ML Estimation",
      fluidRow(add_ui('maximum_likelihood'))),

tabPanel('Dice Roll',
      fluidRow(add_ui('dice_roll'))))