ui = navbarPage(title = 'Table 3.5',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_themes(getShinyOption('theme')),
                header = teachingApps::add_styles(),
                footer = teachingApps::add_footer(),

                
    tabPanel(h4('Table 3.5'), DT::dataTableOutput('table5')))

