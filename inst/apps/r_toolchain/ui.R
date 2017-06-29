ui = navbarPage(title = 'R Toolchain',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_style(),
                footer = teachingApps::add_stamp(),

                 
navbarMenu(h4('Install R'), icon = icon('bar-chart', 'fa-2x'),
   tabPanel(h4('On Windows'), icon = icon('windows', 'fa-2x'),
            fluidRow(uiOutput('rwindows'), class = 'shiny-text-output')),
   tabPanel(h4('On Mac/ios'), icon = icon('apple', 'fa-2x'),
            fluidRow(uiOutput('rmac'),     class = 'shiny-text-output')),
   tabPanel(h4('On Linux'), icon = icon('linux', 'fa-2x'),
            fluidRow(uiOutput('rlinux'),   class = 'shiny-text-output'))),


navbarMenu(h4('Install RStudio'), icon = icon('sitemap', 'fa-2x'),
   tabPanel(h4('On Windows'), icon = icon('windows', 'fa-2x'),
            fluidRow(uiOutput('rswindows'), class = 'shiny-text-output')),
   tabPanel(h4('On Mac/ios'), icon = icon('apple', 'fa-2x'),
            fluidRow(uiOutput('rsmac'),     class = 'shiny-text-output')),
   tabPanel(h4('On Linux'),icon = icon('linux', 'fa-2x'),
            fluidRow(uiOutput('rslinux'),   class = 'shiny-text-output'))),


navbarMenu(h4('Install Rtools'), icon = icon('wrench', 'fa-2x'),
   tabPanel(h4('On Windows'), icon = icon('windows', 'fa-2x'),
            fluidRow(uiOutput('rtwindows'), class = 'shiny-text-output'))),



navbarMenu(h4('Install LaTeX'), icon = icon('text-width', 'fa-2x'),
   tabPanel(h4('On Windows'), icon = icon('windows', 'fa-2x'),
            fluidRow(uiOutput('rlwindows'), class = 'shiny-text-output')),
   tabPanel(h4('On Mac/ios'), icon = icon('apple', 'fa-2x'),
            fluidRow(uiOutput('rlmac'),     class = 'shiny-text-output')),
   tabPanel(h4('On Linux'), icon = icon('linux', 'fa-2x'),
            fluidRow(uiOutput('rllinux'),   class = 'shiny-text-output'))),



navbarMenu(h4('Install Git'), icon = icon("github", 'fa-2x'),
   tabPanel(h4('On Windows'), icon = icon('windows', 'fa-2x'),
            fluidRow(uiOutput('rgwindows'), class = 'shiny-text-output')),
   tabPanel(h4('On Mac/ios'), icon = icon('apple', 'fa-2x'),
            fluidRow(uiOutput('rgmac'),     class = 'shiny-text-output')),
   tabPanel(h4('On Linux'), icon = icon('linux', 'fa-2x'),
            fluidRow(uiOutput('rglinux'),   class = 'shiny-text-output'))))
