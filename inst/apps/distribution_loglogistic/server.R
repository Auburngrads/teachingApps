server = function(input, output, session) {
  
teachingApps::add_server('distribution_loglogistic_functions', envir = environment())
  
output$llogfunc  <- renderUI({ teachingApps::add_rmd('llog-func.Rmd') })

output$llogprops <- renderUI({ teachingApps::add_rmd('llog-props.Rmd')}) 
}