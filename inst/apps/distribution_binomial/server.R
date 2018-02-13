server = function(input, output, session) {
  
     add_server('distribution_binomial_functions', env = environment())

output$binomfunc  <- renderUI({ add_rmd('binom-func.Rmd') })

output$binomprops <- renderUI({ add_rmd('binom-props.Rmd') })
}