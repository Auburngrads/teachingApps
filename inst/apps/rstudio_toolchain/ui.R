ui = navbarPage(title = 'RStudio Toolchain',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),

                 
navbarMenu('Install R',

tabPanel('On Windows',
         
   mainPanel(width = 12,
       tabsetPanel(
  tabPanel(HTML('<orange>1 Install R</orange>'),
           uiOutput("r_windows_p",class = 'ta-text')),
  tabPanel(HTML('<purple>2 Install RStudio</purple>'),
           uiOutput("rs_windows_p",class = 'ta-text')),
  tabPanel(HTML('<green>3 Install Rtools</green>'),
           uiOutput("rt_windows_p",class = 'ta-text')),
  tabPanel(HTML('<red>4 Install LaTeX</red>'),
           uiOutput("l_windows_p", class = 'ta-text')),
  tabPanel(HTML("<blue>5 Install/Configure Git</blue>"),
           uiOutput("g_windows_p", class = 'ta-text')),
  tabPanel(HTML('<brown>6 Create/Link an R-Project</brown>'),
           uiOutput("rp_windows_p", class = 'ta-text'))))),

tabPanel('Windows (AFIT)',
         
   mainPanel(width = 12,
       tabsetPanel(
  tabPanel(HTML('<orange>1 Install R</orange>'),
           uiOutput("r_windows_a", class = 'ta-text')),
  tabPanel(HTML('<purple>2 Install RStudio</purple>'),
           uiOutput("rs_windows_a",class = 'ta-text')),
  tabPanel(HTML('<green>3 Install Rtools</green>'),
           uiOutput("rt_windows_a",class = 'ta-text')),
  tabPanel(HTML('<red>4 Install LaTeX</red>'),
           uiOutput("l_windows_a", class = 'ta-text')),
  tabPanel(HTML('<blue>5 Install/Configure Git</blue>'),
           uiOutput("g_windows_a", class = 'ta-text')),
  tabPanel(HTML('<brown>6 Create/Link an R-Project</brown>'),
           uiOutput("rp_windows_a", class = 'ta-text'))))),

tabPanel('Mac',
         
   mainPanel(width = 12,
       tabsetPanel(
  tabPanel(HTML('<orange>1 Install R</orange>'),
           uiOutput("r_mac", class = 'ta-text')),
  tabPanel(HTML('<purple>2 Install RStudio</purple>'),
           uiOutput("rs_mac",class = 'ta-text')),
  tabPanel(HTML('<green>3 Install Rtools</green>'),
           uiOutput("rt_mac",class = 'ta-text')),
  tabPanel(HTML('<red>4 Install LaTeX</red>'),
           uiOutput("l_mac", class = 'ta-text')),
  tabPanel(HTML('<blue>5 Install/Configure Git</blue>'),
           uiOutput("g_mac", class = 'ta-text')),
  tabPanel(HTML('<brown>6 Create/Link an R-Project</brown>'),
           uiOutput("rp_mac", class = 'ta-text'))))),

tabPanel('Linux',
         
   mainPanel(width = 12,
       tabsetPanel(
  tabPanel(HTML('<orange>1 Install R</orange>'),
           uiOutput("r_linux", class = 'ta-text')),
  tabPanel(HTML('<purple>2 Install RStudio</purple>'),
           uiOutput("rs_linux",class = 'ta-text')),
  tabPanel(HTML('<green>3 Install Rtools</green>'),
           uiOutput("rt_linux",class = 'ta-text')),
  tabPanel(HTML('<red>4 Install LaTeX</red>'),
           uiOutput("l_linux", class = 'ta-text')),
  tabPanel(HTML('<blue>5 Install/Configure Git</blue>'),
           uiOutput("g_linux", class = 'ta-text')),
  tabPanel(HTML('<brown>6 Create/Link an R-Project</brown>'),
           uiOutput("rp_linux", class = 'ta-text'))))),

tabPanel('Unix',
         
   mainPanel(width = 12,
       tabsetPanel(
  tabPanel(HTML('<orange>1 Install R</orange>'),
           uiOutput("r_unix", class = 'ta-text')),
  tabPanel(HTML('<purple>2 Install RStudio</purple>'),
           uiOutput("rs_unix",class = 'ta-text')),
  tabPanel(HTML('<green>3 Install Rtools</green>'),
           uiOutput("rt_unix",class = 'ta-text')),
  tabPanel(HTML('<red>4 Install LaTeX</red>'),
           uiOutput("l_unix", class = 'ta-text')),
  tabPanel(HTML('<blue>5 Install/Configure Git</blue>'),
           uiOutput("g_unix", class = 'ta-text')),
  tabPanel(HTML('<brown>6 Create/Link an R-Project</brown>'),
           uiOutput("rp_unix", class = 'ta-text')))))))


