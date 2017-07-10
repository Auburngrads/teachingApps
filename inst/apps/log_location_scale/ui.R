ui = navbarPage(title = 'Log-Location-Scale Family',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),


tabPanel('Overview',
         uiOutput('overview', class = 'ta-text')),
##########################
tabPanel('Lognormal',
##########################
         uiOutput('lnorfunc',  class = 'ta-text'),
         uiOutput('lnorprops', class = 'ta-text'),
         add_ui('distribution_lognormal_functions')),

##########################
tabPanel('Weibull',
##########################
         uiOutput('weibfunc',  class = 'ta-text'),
         uiOutput('weibprops', class = 'ta-text'),
         add_ui('distribution_weibull_functions')),

##########################
tabPanel('Loglogistic',
##########################
         uiOutput('llogisfunc',  class = 'ta-text'),
         uiOutput('llogisprops', class = 'ta-text'),
         add_ui('distribution_loglogistic_functions')))

