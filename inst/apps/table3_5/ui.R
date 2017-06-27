ui = navbarPage(title = 'Table 3.5',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_style(),
                footer = teachingApps::add_brand(),

                
    tabPanel(h4('Table 3.5'), DT::dataTableOutput('table5')))

