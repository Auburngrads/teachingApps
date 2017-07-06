server = function(input, output, session) {
  
     add_server('distribution_beta_functions', env = environment()) 
  
output$geofunc  <- renderUI({ add_rmd('geo-func.Rmd') })

output$geoprops <- renderUI({ add_rmd('geo-props.Rmd') }) 
}