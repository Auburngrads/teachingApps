ui = navbarPage(title = 'Armadillo Hunting',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),


<<<<<<< HEAD
tabPanel('Overview',
         uiOutput("armadillo_overview", 
                           class = 'ta-text')),
tabPanel('Planning Tool',
      fluidRow(add_ui('acceptance_testing_mtbf'))),

tabPanel('How To Use The Tool',
         uiOutput("howtomtbf", 
                           class = 'ta-text')),

tabPanel('Examples',
         uiOutput("examplemtbf", 
                           class = 'ta-text')),

tabPanel('Background',
         uiOutput("backgroundmtbf", 
                           class = 'ta-text')),

tabPanel('About',
         uiOutput("aboutmtbf", 
                           class = 'ta-text'))))
=======
tabPanel('Example 01', add_ui(path = dirs[1])),

tabPanel('Example 02', add_ui(path = dirs[2])),

tabPanel('Example 04', add_ui(path = dirs[4])),

tabPanel('Example 05', add_ui(path = dirs[5])),

tabPanel('Example 09', add_ui(path = dirs[9])),

tabPanel('Example 10', add_ui(path = dirs[10])),

tabPanel('Example 11', add_ui(path = dirs[11]))
)

>>>>>>> 725cde6e3cf3d4f401624356a8d30a138358fcc1

