ui = navbarPage(title = 'Complex Ideas',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),

                
tabPanel("Conf. Intervals",
        add_ui('confidence_intervals')),

tabPanel("CLT",
         add_ui('central_limit')),

tabPanel("Prob Plots",
         add_ui('probability_plotting')),

tabPanel("Weibull Distro",
         add_ui('distribution_weibull_functions')),

tabPanel("ML Estimation",
         add_ui('maximum_likelihood_simulation')),

tabPanel('Dice Roll',
         add_ui('dice_roll')))