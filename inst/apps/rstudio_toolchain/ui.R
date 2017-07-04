ui = navbarPage(title = 'RStudio Toolchain',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_css(),
                footer = teachingApps::add_logo(),

                 
navbarMenu('Install R',

tabPanel('On Windows',
         
   mainPanel(width = 12,
       tabsetPanel(
  tabPanel(HTML('<orange>1 Install R</orange>'),
           uiOutput("r_windows_p",class = 'shiny-text-output')),
  tabPanel(HTML('<purple>2 Install RStudio</purple>'),
           uiOutput("rs_windows_p",class = 'shiny-text-output')),
  tabPanel(HTML('<green>3 Install Rtools</green>'),
           uiOutput("rt_windows_p",class = 'shiny-text-output')),
  tabPanel(HTML('<red>4 Install LaTeX</red>'),
           uiOutput("l_windows_p", class = 'shiny-text-output')),
  tabPanel(HTML("<blue>5 Install/Configure Git</blue>"),
           uiOutput("g_windows_p", class = 'shiny-text-output')),
  tabPanel(HTML('<brown>6 Create/Link an R-Project</brown>'),
           uiOutput("rp_windows_p", class = 'shiny-text-output'))))),

tabPanel('Windows (AFIT)',
         
   mainPanel(width = 12,
       tabsetPanel(
  tabPanel(HTML('<orange>1 Install R</orange>'),
           uiOutput("r_windows_a", class = 'shiny-text-output')),
  tabPanel(HTML('<purple>2 Install RStudio</purple>'),
           uiOutput("rs_windows_a",class = 'shiny-text-output')),
  tabPanel(HTML('<green>3 Install Rtools</green>'),
           uiOutput("rt_windows_a",class = 'shiny-text-output')),
  tabPanel(HTML('<red>4 Install LaTeX</red>'),
           uiOutput("l_windows_a", class = 'shiny-text-output')),
  tabPanel(HTML('<blue>5 Install/Configure Git</blue>'),
           uiOutput("g_windows_a", class = 'shiny-text-output')),
  tabPanel(HTML('<brown>6 Create/Link an R-Project</brown>'),
           uiOutput("rp_windows_a", class = 'shiny-text-output'))))),

tabPanel('Mac',
         
   mainPanel(width = 12,
       tabsetPanel(
  tabPanel(HTML('<orange>1 Install R</orange>'),
           uiOutput("r_mac", class = 'shiny-text-output')),
  tabPanel(HTML('<purple>2 Install RStudio</purple>'),
           uiOutput("rs_mac",class = 'shiny-text-output')),
  tabPanel(HTML('<green>3 Install Rtools</green>'),
           uiOutput("rt_mac",class = 'shiny-text-output')),
  tabPanel(HTML('<red>4 Install LaTeX</red>'),
           uiOutput("l_mac", class = 'shiny-text-output')),
  tabPanel(HTML('<blue>5 Install/Configure Git</blue>'),
           uiOutput("g_mac", class = 'shiny-text-output')),
  tabPanel(HTML('<brown>6 Create/Link an R-Project</brown>'),
           uiOutput("rp_mac", class = 'shiny-text-output'))))),

tabPanel('Linux',
         
   mainPanel(width = 12,
       tabsetPanel(
  tabPanel(HTML('<orange>1 Install R</orange>'),
           uiOutput("r_linux", class = 'shiny-text-output')),
  tabPanel(HTML('<purple>2 Install RStudio</purple>'),
           uiOutput("rs_linux",class = 'shiny-text-output')),
  tabPanel(HTML('<green>3 Install Rtools</green>'),
           uiOutput("rt_linux",class = 'shiny-text-output')),
  tabPanel(HTML('<red>4 Install LaTeX</red>'),
           uiOutput("l_linux", class = 'shiny-text-output')),
  tabPanel(HTML('<blue>5 Install/Configure Git</blue>'),
           uiOutput("g_linux", class = 'shiny-text-output')),
  tabPanel(HTML('<brown>6 Create/Link an R-Project</brown>'),
           uiOutput("rp_linux", class = 'shiny-text-output'))))),

tabPanel('Unix',
         
   mainPanel(width = 12,
       tabsetPanel(
  tabPanel(HTML('<orange>1 Install R</orange>'),
           uiOutput("r_unix", class = 'shiny-text-output')),
  tabPanel(HTML('<purple>2 Install RStudio</purple>'),
           uiOutput("rs_unix",class = 'shiny-text-output')),
  tabPanel(HTML('<green>3 Install Rtools</green>'),
           uiOutput("rt_unix",class = 'shiny-text-output')),
  tabPanel(HTML('<red>4 Install LaTeX</red>'),
           uiOutput("l_unix", class = 'shiny-text-output')),
  tabPanel(HTML('<blue>5 Install/Configure Git</blue>'),
           uiOutput("g_unix", class = 'shiny-text-output')),
  tabPanel(HTML('<brown>6 Create/Link an R-Project</brown>'),
           uiOutput("rp_unix", class = 'shiny-text-output')))))))


