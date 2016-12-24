server = function(input, output, session) {
  
output$delta <- renderUI({ nestRmd('background.Rmd') })

output$greenwood <- renderUI({ nestRmd('greenwood.Rmd') })
}