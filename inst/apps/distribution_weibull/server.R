server = function(input, output, session) {
  
teachingApps::add_server('distribution_weibull_functions', envir = environment())
  
output$weibfunc  <- renderUI({ teachingApps::add_rmd('weib-func.Rmd') })

output$weibprops <- renderUI({ teachingApps::add_rmd('weib-props.Rmd') }) 

}