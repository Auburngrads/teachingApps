server = function(input, output, session) {
  
     add_server('distribution_logistic_functions', env = environment())
  
output$logfunc  <- renderUI({ add_rmd('log-func.Rmd') })

output$logprops <- renderUI({ add_rmd('log-props.Rmd') }) 
}