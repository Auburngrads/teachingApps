server = function(input, output, session) {
  
output$delta <- renderUI({ add_rmd('background.Rmd') })

output$greenwood <- renderUI({ add_rmd('greenwood.Rmd') })
}