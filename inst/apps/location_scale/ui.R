ui = navbarPage(title = 'Location-Scale Family',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),


tabPanel('Overview',
         uiOutput('overview', class = 'ta-text')),
#############################
tabPanel('Exponential',
#############################
         uiOutput('expfunc',  class = 'ta-text'),
         uiOutput('expprops', class = 'ta-text'),
           add_ui('distribution_exponential_functions')),

#######################
tabPanel('Normal',
#######################
         uiOutput('norfunc',  class = 'ta-text'),
         uiOutput('norprops', class = 'ta-text'),
           add_ui('distribution_normal_functions')),

#######################################
tabPanel('SEV',
#######################################
         uiOutput('sevfunc',  class = 'ta-text'),
         uiOutput('sevprops', class = 'ta-text'),
           add_ui('distribution_sev_functions')),

######################################
tabPanel('LEV',
######################################
         uiOutput('levfunc',  class = 'ta-text'),
         uiOutput('levprops', class = 'ta-text'),
           add_ui('distribution_lev_functions')),

######################################
tabPanel('Logistic',
######################################
         uiOutput('logisfunc',  class = 'ta-text'),
         uiOutput('logisprops', class = 'ta-text'),
           add_ui('distribution_logistic_functions')))
