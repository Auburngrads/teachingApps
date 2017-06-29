server = function(input, output, session) {
  
teachingApps::add_server('distribution_lognormal', envir = environment())  

output$lnorfunc  <- renderUI({ teachingApps::add_rmd('lnor-func.Rmd') })

output$lnorprops <- renderUI({ teachingApps::add_rmd('lnor-props.Rmd') }) 
}