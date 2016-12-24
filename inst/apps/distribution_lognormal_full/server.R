server = function(input, output, session) {
  
teachingApps::nestServer('distribution_lognormal', envir = environment())  

output$lnorfunc  <- renderUI({ teachingApps::nestRmd('lnor-func.Rmd') })

output$lnorprops <- renderUI({ teachingApps::nestRmd('lnor-props.Rmd') }) 
}