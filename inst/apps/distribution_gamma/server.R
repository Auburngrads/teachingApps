server = function(input, output, session) {
  
     add_server('distribution_gamma_functions', env = environment())

output$gammafunc  <- renderUI({ add_rmd('gamma-func.Rmd') })

output$gammaprops <- renderUI({ add_rmd('gamma-props.Rmd') })
}