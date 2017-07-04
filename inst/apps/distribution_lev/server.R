server = function(input, output, session) {
  
teachingApps::add_server('distribution_beta_functions', envir = environment())
  
output$levfunc  <- renderUI({teachingApps::add_rmd('lev-func.Rmd') })

output$levprops <- renderUI({teachingApps::add_rmd('lev-props.Rmd') }) 
}