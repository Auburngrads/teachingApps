library(teachingApps)


ui = navbarPage(title = 'RStudio Toolchain',
                collapsible = T, 
                position = 'fixed-top',
                theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
                header = tags$head(includeCSS(getShinyOption("css"))),
                footer = HTML(teachingApps::teachingApp(getShinyOption("appName"))),
                 
navbarMenu(h4('Install R')),

tabPanel(h4('On Windows'),
         
   mainPanel(width = 12,
       tabsetPanel(
  tabPanel(h4(HTML('<orange>1) Install R</orange>')),uiOutput("r_windows_p",class = 'shiny-text-output')),
  tabPanel(h4(HTML('<purple>2) Install RStudio</purple>')), uiOutput("rs_windows_p",class = 'shiny-text-output')),
  tabPanel(h4(HTML('<green>3) Install Rtools</green>')),  uiOutput("rt_windows_p",class = 'shiny-text-output')),
  tabPanel(h4(HTML('<red>4) Install LaTeX</red>')),   uiOutput("l_windows_p", class = 'shiny-text-output')),
  tabPanel(h4(HTML("<blue>5) Install/Configure Git</blue>")),uiOutput("g_windows_p", class = 'shiny-text-output')),
  tabPanel(h4(HTML('<brown>6) Create/Link an R-Project</brown>')),   uiOutput("rp_windows_p", class = 'shiny-text-output'))))),

tabPanel(h4('Windows (AFIT)'),
         
   mainPanel(width = 12,
       tabsetPanel(
  tabPanel(h4(HTML('<orange>1) Install R</orange>')),       uiOutput("r_windows_a", class = 'shiny-text-output')),
  tabPanel(h4(HTML('<purple>2) Install RStudio</purple>')), uiOutput("rs_windows_a",class = 'shiny-text-output')),
  tabPanel(h4(HTML('<green>3) Install Rtools</green>')),  uiOutput("rt_windows_a",class = 'shiny-text-output')),
  tabPanel(h4(HTML('<red>4) Install LaTeX</red>')),   uiOutput("l_windows_a", class = 'shiny-text-output')),
  tabPanel(h4(HTML('<blue>5) Install/Configure Git</blue>')),     uiOutput("g_windows_a", class = 'shiny-text-output')),
  tabPanel(h4(HTML('<brown>6) Create/Link an R-Project</brown>')),   uiOutput("rp_windows_a", class = 'shiny-text-output'))))),

tabPanel(h4('Mac'),
         
   mainPanel(width = 12,
       tabsetPanel(
  tabPanel(h4(HTML('<orange>1) Install R</orange>')),       uiOutput("r_mac", class = 'shiny-text-output')),
  tabPanel(h4(HTML('<purple>2) Install RStudio</purple>')), uiOutput("rs_mac",class = 'shiny-text-output')),
  tabPanel(h4(HTML('<green>3) Install Rtools</green>')),  uiOutput("rt_mac",class = 'shiny-text-output')),
  tabPanel(h4(HTML('<red>4) Install LaTeX</red>')),   uiOutput("l_mac", class = 'shiny-text-output')),
  tabPanel(h4(HTML('<blue>5) Install/Configure Git</blue>')),     uiOutput("g_mac", class = 'shiny-text-output')),
  tabPanel(h4(HTML('<brown>6) Create/Link an R-Project</brown>')),   uiOutput("rp_mac", class = 'shiny-text-output'))))),

tabPanel(h4('Linux'),
         
   mainPanel(width = 12,
       tabsetPanel(
  tabPanel(h4(HTML('<orange>1) Install R</orange>')),       uiOutput("r_linux", class = 'shiny-text-output')),
  tabPanel(h4(HTML('<purple>2) Install RStudio</purple>')), uiOutput("rs_linux",class = 'shiny-text-output')),
  tabPanel(h4(HTML('<green>3) Install Rtools</green>')),  uiOutput("rt_linux",class = 'shiny-text-output')),
  tabPanel(h4(HTML('<red>4) Install LaTeX</red>')),   uiOutput("l_linux", class = 'shiny-text-output')),
  tabPanel(h4(HTML('<blue>5) Install/Configure Git</blue>')),     uiOutput("g_linux", class = 'shiny-text-output')),
  tabPanel(h4(HTML('<brown>6) Create/Link an R-Project</brown>')),   uiOutput("rp_linux", class = 'shiny-text-output'))))),

tabPanel(h4('Unix'),
         
   mainPanel(width = 12,
       tabsetPanel(
  tabPanel(h4(HTML('<orange>1) Install R</orange>')),       uiOutput("r_unix", class = 'shiny-text-output')),
  tabPanel(h4(HTML('<purple>2) Install RStudio</purple>')), uiOutput("rs_unix",class = 'shiny-text-output')),
  tabPanel(h4(HTML('<green>3) Install Rtools</green>')),  uiOutput("rt_unix",class = 'shiny-text-output')),
  tabPanel(h4(HTML('<red>4) Install LaTeX</red>')),   uiOutput("l_unix", class = 'shiny-text-output')),
  tabPanel(h4(HTML('<blue>5) Install/Configure Git</blue>')),     uiOutput("g_unix", class = 'shiny-text-output')),
  tabPanel(h4(HTML('<brown>6) Create/Link an R-Project</brown>')),   uiOutput("rp_unix", class = 'shiny-text-output'))))))


