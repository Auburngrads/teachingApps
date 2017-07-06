server = function(input, output, session) {
  
     add_server('distribution_loglogistic_functions', env = environment())
  
output$llogfunc  <- renderUI({ add_rmd('llog-func.Rmd') })

output$llogprops <- renderUI({ add_rmd('llog-props.Rmd')}) 
}