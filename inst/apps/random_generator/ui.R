ui = navbarPage(title = 'Pseudorandom Observations',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),

                  
    tabPanel('PRN Data', DT::dataTableOutput('prn')))

