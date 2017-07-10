ui = navbarPage(title = 'R Toolchain',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),
                 
navbarMenu('Install R', 
           icon = icon('bar-chart'),
           
tabPanel('On Windows', 
         icon = icon('windows'),
         uiOutput('rwindows', class = 'ta-text')),
tabPanel('On Mac/ios', 
         icon = icon('apple'),
         uiOutput('rmac',  class = 'ta-text')),
tabPanel('On Linux', 
         icon = icon('linux'),
         uiOutput('rlinux', class = 'ta-text'))),


navbarMenu('Install RStudio', 
           icon = icon('sitemap'),
           
tabPanel('On Windows', 
         icon = icon('windows'),
         uiOutput('rswindows', class = 'ta-text')),
tabPanel('On Mac/ios', 
         icon = icon('apple'),
         uiOutput('rsmac', class = 'ta-text')),
tabPanel('On Linux',
         icon = icon('linux'),
         uiOutput('rslinux', class = 'ta-text'))),


navbarMenu('Install Rtools', 
           icon = icon('wrench'),
           
tabPanel('On Windows', 
         icon = icon('windows'),
         uiOutput('rtwindows', class = 'ta-text'))),

navbarMenu('Install LaTeX', 
           icon = icon('text-width'),
           
tabPanel('On Windows', 
         icon = icon('windows'),
         uiOutput('rlwindows', class = 'ta-text')),
tabPanel('On Mac/ios', 
         icon = icon('apple'),
         uiOutput('rlmac', class = 'ta-text')),
tabPanel('On Linux', 
         icon = icon('linux'),
         uiOutput('rllinux',   class = 'ta-text'))),


navbarMenu('Install Git', 
           icon = icon("github"),
           
tabPanel('On Windows', 
         icon = icon('windows'),
         uiOutput('rgwindows', class = 'ta-text')),
tabPanel('On Mac/ios', 
         icon = icon('apple'),
         uiOutput('rgmac', class = 'ta-text')),
tabPanel('On Linux', 
         icon = icon('linux'),
         uiOutput('rglinux', class = 'ta-text'))))
