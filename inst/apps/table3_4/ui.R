ui = navbarPage(title = 'Table 3.4',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_themes(getShinyOption('theme')),
                header = teachingApps::add_styles(),
                footer = teachingApps::add_footer(),

        
      tabPanel(h4('Data Set'),DT::dataTableOutput("table.shock1", height = "80%")),
      tabPanel(h4('Data Set'),DT::dataTableOutput("table.shock2", height = "80%")))
