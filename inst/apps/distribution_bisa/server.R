server = function(input, output, session) {
  
     add_server('distribution_bisa_functions', env = environment())

output$bisafunc  <- renderUI({ add_rmd('bisa-func.Rmd') })

output$bisaprops <- renderUI({ add_rmd('bisa-props.Rmd') })
}