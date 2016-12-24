server = function(input, output, session) {
  
teachingApps::nestServer('distribution_beta', envir = environment()) 
  
output$geofunc  <- renderUI({ teachingApps::nestRmd('geo-func.Rmd') })

output$geoprops <- renderUI({ teachingApps::nestRmd('geo-props.Rmd') }) 
}