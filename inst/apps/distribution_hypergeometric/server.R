server = function(input, output, session) {
  
     add_server('distribution_hypergeometric_functions', env = environment())

output$hyperfunc  <- renderUI({ add_rmd('hyper-func.Rmd') })

output$hyperprops <- renderUI({ add_rmd('hyper-props.Rmd') })
}