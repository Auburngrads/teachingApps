server = function(input, output, session) {
  
     add_server('distribution_geometric_functions', env = environment()) 
  
output$geofunc  <- renderUI({ add_rmd('geo-func.Rmd') })

output$geoprops <- renderUI({ add_rmd('geo-props.Rmd') }) 
}