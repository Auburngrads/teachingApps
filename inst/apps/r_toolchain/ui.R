ui = navbarPage(title = 'R Toolchain',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_css(),
                footer = teachingApps::add_logo(),

                 
navbarMenu('Install R', icon = icon('bar-chart', 'fa-2x'),
   tabPanel('On Windows', icon = icon('windows', 'fa-2x'),
            fluidRow(uiOutput('rwindows', class = 'ta-text'))),
   tabPanel('On Mac/ios', icon = icon('apple', 'fa-2x'),
            fluidRow(uiOutput('rmac'),     class = 'ta-text')),
   tabPanel('On Linux', icon = icon('linux', 'fa-2x'),
            fluidRow(uiOutput('rlinux'),   class = 'ta-text'))),


navbarMenu('Install RStudio', icon = icon('sitemap', 'fa-2x'),
   tabPanel('On Windows', icon = icon('windows', 'fa-2x'),
            fluidRow(uiOutput('rswindows', class = 'ta-text'))),
   tabPanel('On Mac/ios', icon = icon('apple', 'fa-2x'),
            fluidRow(uiOutput('rsmac'),     class = 'ta-text')),
   tabPanel('On Linux',icon = icon('linux', 'fa-2x'),
            fluidRow(uiOutput('rslinux'),   class = 'ta-text'))),


navbarMenu('Install Rtools', icon = icon('wrench', 'fa-2x'),
   tabPanel('On Windows', icon = icon('windows', 'fa-2x'),
            fluidRow(uiOutput('rtwindows'), class = 'ta-text'))),



navbarMenu('Install LaTeX', icon = icon('text-width', 'fa-2x'),
   tabPanel('On Windows', icon = icon('windows', 'fa-2x'),
            fluidRow(uiOutput('rlwindows', class = 'ta-text'))),
   tabPanel('On Mac/ios', icon = icon('apple', 'fa-2x'),
            fluidRow(uiOutput('rlmac'),     class = 'ta-text')),
   tabPanel('On Linux', icon = icon('linux', 'fa-2x'),
            fluidRow(uiOutput('rllinux'),   class = 'ta-text'))),



navbarMenu('Install Git', icon = icon("github", 'fa-2x'),
   tabPanel('On Windows', icon = icon('windows', 'fa-2x'),
            fluidRow(uiOutput('rgwindows', class = 'ta-text'))),
   tabPanel('On Mac/ios', icon = icon('apple', 'fa-2x'),
            fluidRow(uiOutput('rgmac'),     class = 'ta-text')),
   tabPanel('On Linux', icon = icon('linux', 'fa-2x'),
            fluidRow(uiOutput('rglinux'),   class = 'ta-text'))))
