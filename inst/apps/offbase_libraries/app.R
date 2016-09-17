library(pos = -1,  package = 'leaflet')
library(pos = -1,  package = 'publicLibs', repo = 'Auburngrads')
library(pos = -1,  package = 'data.table')









shinyApp(options = list(height = '800px', width = '100%'),

    ui = navbarPage(theme = shinythemes::shinytheme('flatly'),
                    try(includeCSS(system.file('css',
                                               'my-shiny.css',
                                               package = 'teachingApps')), silent = T),

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
         
         mainPanel(uiOutput('aboutlib', height = '600px'), width = 12)),

fixedPanel(htmlOutput('sign'),bottom = '1%', right = '1%', height = '30px')),

server = function(input, output, session) {

  output$sign <- renderUI({HTML(teachingApps::teachingApp(basename(getwd())))})

output$libmap <- renderLeaflet({

    Base_Locs <- read.table(system.file('extdata','Base_Locations.txt',
                                         package = 'publicLibs'),
                             header = TRUE, stringsAsFactors = F)
    abb <- Base_Locs[which(Base_Locs[,1]%in%input$bases),3]
    lib <- eval(parse(text = paste(c(abb,'_Libs'), collapse = '')))
    lib <- subset(lib, `miles`<=input$radius)


    leaflet(lib) %>%
      addTiles() %>%
      addMarkers(~latitude,~longitude, popup = ~location)
})
output$aboutlib <- renderUI({HTML('good stuff goes here')

})
})
