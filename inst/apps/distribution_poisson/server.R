server = function(input, output, session) {
  
teachingApps::add_server('distribution_poisson_functions', envir = environment())
  
output$poifunc  <- renderUI({ teachingApps::add_rmd('poi-func.Rmd') })

output$poiprops <- renderUI({ teachingApps::add_rmd('poi-props.Rmd') }) 
}