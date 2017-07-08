ui = navbarPage(title = 'Armadillo Hunting',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),


tabPanel('Example 01',
         add_ui(path = dirs[1])),

tabPanel('Example 02',
         add_ui(path = dirs[2])),

tabPanel('Example 04',
         add_ui(path = dirs[4])),

tabPanel('Example 05',
         add_ui(path = dirs[5])),

tabPanel('Example 09',
         add_ui(path = dirs[9])),

tabPanel('Example 10',
         add_ui(path = dirs[10])),

tabPanel('Example 11',
         add_ui(path = dirs[11]))
)


