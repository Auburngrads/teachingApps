rstudio_toolkit <- function(...) {

try(attachNamespace('shiny'), silent = TRUE)
try(attachNamespace('codemirrorR'), silent = TRUE)

shinyApp(options = list(height = '800px', width = '100%'),
         
    ui = navbarPage(theme = shinythemes::shinytheme('flatly'), 
                    try(includeCSS(system.file('css',
                                               'my-shiny.css', 
                                               package = 'teachingApps')), silent = T),
   
tabPanel(h4('Windows (Personal)'),
         
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
  tabPanel(h4(HTML('<brown>6) Create/Link an R-Project</brown>')),   uiOutput("rp_unix", class = 'shiny-text-output')))))),

server <- function(input, output) {

  install_rw <- HTML( 
"<h1>Procedure for Installing and Setting Up R</h1>
<hr>
<ol>
<li>
Go to <a target='' href='https://cloud.r-project.org/'>https://cloud.r-project.org/</a> and download latest version of R
</li>
<li>
During the installation process, accept all of the defaults 
</li>
<li>
Once the install is complete, open R - admittedly it's not very exciting to look at, RStudio will help with that
</li>
<li>
At the command prompt type <code>.libPaths()</code> 
<ul>
<li>
This function returns the directories where R can store your downloaded packages
</li>
<li>
As you're installing R for the first time, there may be only one directory listed now - as you use R the number of directories is likely to increase
</li>
<li>
The order of the directories indicates the order R will use in trying to store the package
</li>
<li>
A custom library may be specified by creating an environment variable called <code>R_LIBS</code> and assigning it the path of the desired folder
</li>
<li>
If you don't know how to set environment variables don't worry about this right now
</li>
</ul>
</li>
<li>
Now type <code>names(installed.packages()[,1])</code> 
<ul>
<li>
This returns a list of the packages that installs with R
</li>
<li>
These packages should be stored in the first directory returned by <code>.libPaths()</code> 
</li>
</ul>
</li>
</ol>
<hr>
<h1>Installing R Packages</h1>
<hr>
<ol>
<li>
The real power of R is experienced by using AND creating packages
</li>
<li>
R packages can be downloaded and used like apps on your smartphone
<ul>
<li>
Packages allow researchers to share their work with the world, very quickly  
</li>
<li>
Packages allow users to use the latest methods, almost immediately after they are developed
</li>
<li>
In many cases <focus>there's <s>an app</s> a package for that!</focus>
</li>
</ul>
</li>
<li>
There are also several 'stores' or repositories from which packages can be installed
<ul>
<li>
The Comprehensive R Archive Network (CRAN) - the official repository for R packages  
</li>
<li>
<a target='' href='http://github.com'>GitHub</a> - many packages are stored here prior to being accepted for publication to the CRAN
</li>
<li>
<a target='' href='http://bioconductor.org/'>Bioconductor</a> - a repository of bioinformatics-related R packages
</li>
<li>
The Microsoft R Archive Network (<a target='' href='https://mran.revolutionanalytics.com/'>MRAN</a>)
</li>
</ul>
</li>
<li>
Ok, let's install a package to make sure everything is working
<ul>
<li>
Run <code> install.packages('data.table')</code> to install the <code>data.table</code> package from the CRAN
</li>
<li>
As this is your first package, you will likely be asked to choose a 'CRAN mirror' - select <code>0 - Cloud</code> 
</li>
<li>
You may then be asked if you would like to create a personal library - select Yes and accept the default folder location 
</li>
<li>
If the package (and it's dependencies) downloaded you're all set to continue 
</li>
<li>
If the package failed to download, skip ahead to <purple>2) Installing RStudio</purple> and try to install the <code>data.table</code> package again once RStudio is installed
</li>
</ul>
</li>
<li>
In addition to the <code>data.table</code> package there are several packages every R user needs 
</li>
<li>
To install these packages paste the following lines into R <u>one at a time</u>
</li>
<ul>
<li>
<code>install.packages(c('installr','devtools','rmarkdown'))</code>
</li>
<li>
<code>install.packages(c('DT','knitcitations','RefManageR'))</code>
</li>
<li>
<code>install.packages(c('shiny','RJSONIO','xtable'))</code>
</li>
</ul>
</li>
<li>
If these packages (and their dependencies) installed - you're all set!
</li>
</ol>
")
  
  output$r_windows_p <- renderUI({ install_rw })
output$rs_windows_p <- renderUI({HTML( ) })
output$rt_windows_p <- renderUI({HTML( ) })
output$l_windows_p  <- renderUI({HTML( ) })
output$g_windows_p  <- renderUI({HTML( ) })

output$r_windows_a  <- renderUI({ install_rw })
output$rs_windows_a <- renderUI({HTML( ) })
output$rt_windows_a <- renderUI({HTML( ) })
output$l_windows_a  <- renderUI({HTML( ) })
output$g_windows_a  <- renderUI({HTML( ) })

output$r_mac  <- renderUI({ install_rw })
output$rs_mac <- renderUI({HTML( ) })
output$rt_mac <- renderUI({HTML( ) })
output$l_mac  <- renderUI({HTML( ) })
output$g_mac  <- renderUI({HTML( ) })
  
output$r_linux  <- renderUI({ install_rw })
output$rs_linux <- renderUI({HTML( ) })
output$rt_linux <- renderUI({HTML( ) })
output$l_linux  <- renderUI({HTML( ) })
output$g_linux  <- renderUI({HTML( ) })

output$r_unix  <- renderUI({ install_rw })
output$rs_unix <- renderUI({HTML( ) })
output$rt_unix <- renderUI({HTML( ) })
output$l_unix  <- renderUI({HTML( ) })
output$g_unix  <- renderUI({HTML( ) })
})
}

