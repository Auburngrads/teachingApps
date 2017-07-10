server = function(input, output, session) {

output$libmap <- renderLeaflet({

    Base_Locs <- read.table(system.file('extdata','Base_Locations.txt',
                                         package = 'publicLibs'),
                             header = TRUE, stringsAsFactors = F)
    abb <- Base_Locs[which(Base_Locs[,1]%in%input$bases),3]
    lib <- eval(parse(text = paste0(abb,'_Libs')))
    lib <- subset(lib, `miles`<=input$radius)


    leaflet(lib) %>%
      addTiles() %>%
      addMarkers(~latitude,~longitude, popup = ~location)
})
output$aboutlib <- renderUI({HTML('good stuff goes here')

})
}