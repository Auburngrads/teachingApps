server = function(input, output, session) {
  
teachingApps::nestServer('distribution_weibull', envir = environment())
  
output$weibfunc  <- renderUI({ teachingApps::nestRmd('weib-func.Rmd') })

output$weibprops <- renderUI({ teachingApps::nestRmd('weib-props.Rmd') }) 

}