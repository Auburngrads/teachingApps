offbase_libraries <- function() {

try(attachNamespace('shiny'), silent = TRUE)
try(attachNamespace('leaflet'), silent = TRUE)
try(attachNamespace('publicLibs'), silent = TRUE)
try(attachNamespace('data.table'), silent = TRUE)

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
         mainPanel(uiOutput('aboutlib', height = '600px'), width = 12))),


server = function(input, output, session) {

output$libmap <- renderLeaflet({

    Base_Locs <- data.table(publicLibs::Base_Locations)
    num <- which(Base_Locs[,`Base (Long Name)`==input$bases])
    abb <- Base_Locs[num,`Base (Abbreviation)`]
    lib <- eval(parse(text = paste(c(abb,'_Libs'), collapse = '')))
    lib <- subset(lib, lib[,`miles`<=input$radius])


    leaflet(lib) %>%
      addTiles() %>%
      addMarkers(~latitude,~longitude, popup = ~location)
})
output$aboutlib <- renderUI({HTML('good stuff goes here')})

})
}

