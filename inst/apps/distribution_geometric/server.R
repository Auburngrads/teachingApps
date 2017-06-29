server = function(input, output, session) {
  
teachingApps::add_server('distribution_beta', envir = environment()) 
  
output$geofunc  <- renderUI({ teachingApps::add_rmd('geo-func.Rmd') })

output$geoprops <- renderUI({ teachingApps::add_rmd('geo-props.Rmd') }) 
}