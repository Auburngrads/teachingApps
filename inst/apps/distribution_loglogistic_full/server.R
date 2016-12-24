server = function(input, output, session) {
  
teachingApps::nestServer('distribution_loglogistic', envir = environment())
  
output$llogfunc  <- renderUI({ teachingApps::nestRmd('llog-func.Rmd') })

output$llogprops <- renderUI({ teachingApps::nestRmd('llog-props.Rmd')}) 
}