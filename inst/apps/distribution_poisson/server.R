server = function(input, output, session) {
  
     add_server('distribution_poisson_functions', env = environment())
  
output$poifunc  <- renderUI({ add_rmd('poi-func.Rmd') })

output$poiprops <- renderUI({ add_rmd('poi-props.Rmd') }) 
}