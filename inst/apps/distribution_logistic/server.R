server = function(input, output, session) {
  
teachingApps::add_server('distribution_logistic', envir = environment())
  
output$logfunc  <- renderUI({ teachingApps::add_rmd('log-func.Rmd') })

output$logprops <- renderUI({ teachingApps::add_rmd('log-props.Rmd') }) 
}