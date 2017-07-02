ui = navbarPage(title = 'Pseudorandom Observations',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_css(),
                footer = teachingApps::add_stamp(),

                  
    tabPanel(h4('PRN Data'), DT::dataTableOutput('prn')))

