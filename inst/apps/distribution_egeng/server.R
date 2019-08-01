server = function(input, output, session) {
  
     add_server('distribution_egeng_functions', env = environment())

output$gengfunc  <- renderUI({ add_rmd('egeng-func.Rmd') })

output$gengprops <- renderUI({ add_rmd('egeng-props.Rmd') })
}