server = function(input, output, session) {
  
     add_server('distribution_igau_functions', env = environment())

output$bisafunc  <- renderUI({ add_rmd('igau-func.Rmd') })

output$bisaprops <- renderUI({ add_rmd('igau-props.Rmd') })
}