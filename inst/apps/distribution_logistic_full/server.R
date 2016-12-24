server = function(input, output, session) {
  
teachingApps::nestServer('distribution_logistic', envir = environment())
  
output$logfunc  <- renderUI({ teachingApps::nestRmd('log-func.Rmd') })

output$logprops <- renderUI({ teachingApps::nestRmd('log-props.Rmd') }) 
}