server = function(input, output, session) {
  
output$delta <- renderUI({ insertRmd('background.Rmd') })

output$greenwood <- renderUI({ insertRmd('greenwood.Rmd') })
}