server = function(input, output, session) {
  
     add_server('distribution_exponential_functions', env = environment())

output$expfunc  <- renderUI({ add_rmd('exp-func.Rmd') })

output$expprops <- renderUI({ add_rmd('exp-props.Rmd') })
}