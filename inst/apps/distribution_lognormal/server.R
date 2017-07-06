server = function(input, output, session) {
  
     add_server('distribution_lognormal_functions', env = environment())  

output$lnorfunc  <- renderUI({ add_rmd('lnor-func.Rmd') })

output$lnorprops <- renderUI({ add_rmd('lnor-props.Rmd') }) 
}