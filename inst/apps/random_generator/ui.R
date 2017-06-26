ui = navbarPage(title = 'Pseudorandom Observations',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_themes(getShinyOption('theme')),
                header = teachingApps::add_styles(),
                footer = teachingApps::add_footer(),

                  
    tabPanel(h4('PRN Data'), DT::dataTableOutput('prn')))

