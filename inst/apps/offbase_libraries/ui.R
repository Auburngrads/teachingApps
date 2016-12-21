library(teachingApps)
library('leaflet')
library('publicLibs')
library('data.table')

ui = navbarPage(title = 'Offbase Libraries',
                collapsible = T, 
                position = 'fixed-top',
                theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
                header = tags$head(includeCSS(getShinyOption("css"))),
                footer = HTML(teachingApps::teachingApp(getShinyOption("appName"))),

tabPanel(h4('Off-Base Libraries'),
         sidebarLayout(
           sidebarPanel(width = 3,
              selectInput('bases',
                          h2('U.S. Air Force Bases'),
                          choices = Base_Locations[,1],
                          selected = 'Wright-Patterson AFB'),
              sliderInput('radius',
                          h2('Distance From Base'),
                          min = 10,
                          max = 100,
                          step = 5,
                          value = 20,
                          animate = T)),
           mainPanel(leafletOutput('libmap', height = '600px'), width = 9))),

tabPanel(h4('About This Tool'),
         
         mainPanel(uiOutput('aboutlib', height = '600px'), width = 12)))
