ui = navbarPage(title = 'Offbase Libraries',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),


tabPanel('Off-Base Libraries',
         sidebarLayout(
           sidebarPanel(width = 3,
              selectInput('bases',
                          'U.S. Air Force Bases'),
                          choices = Base_Locations[,1],
                          selected = 'Wright-Patterson AFB'),
              sliderInput('radius',
                          'Distance From Base'),
                          min = 10,
                          max = 100,
                          step = 5,
                          value = 20,
                          animate = T)),
           mainPanel(leafletOutput('libmap', height = '600px'), width = 9))),

tabPanel('About This Tool'),
         
         uiOutput('aboutlib', height = '600px'), width = 12)))
