server = function(input, output, session) {
  
     add_server('distribution_goma_functions', env = environment())

output$bisafunc  <- renderUI({ add_rmd('goma-func.Rmd') })

output$bisaprops <- renderUI({ add_rmd('goma-props.Rmd') })
}