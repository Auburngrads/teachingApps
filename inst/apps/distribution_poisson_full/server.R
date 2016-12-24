server = function(input, output, session) {
  
teachingApps::nestServer('distribution_poisson', envir = environment())
  
output$poifunc  <- renderUI({ teachingApps::nestRmd('poi-func.Rmd') })

output$poiprops <- renderUI({ teachingApps::nestRmd('poi-props.Rmd') }) 
}