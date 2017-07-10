server = function(input, output, session) {
  
     add_server('distribution_lev_functions', env = environment())
  
output$levfunc  <- renderUI({add_rmd('lev-func.Rmd') })

output$levprops <- renderUI({add_rmd('lev-props.Rmd') }) 
}