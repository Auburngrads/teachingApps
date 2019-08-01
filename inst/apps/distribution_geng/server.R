server = function(input, output, session) {
  
     add_server('distribution_geng_functions', env = environment())

output$gengfunc  <- renderUI({ add_rmd('geng-func.Rmd') })

output$gengprops <- renderUI({ add_rmd('geng-props.Rmd') })
}