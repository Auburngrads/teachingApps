server = function(input, output, session) {
  
teachingApps::nestServer('distribution_exponential', envir = environment())

output$expfunc  <- renderUI({ teachingApps::nestRmd('exp-func.Rmd') })

output$expprops <- renderUI({ teachingApps::nestRmd('exp-props.Rmd') })
}