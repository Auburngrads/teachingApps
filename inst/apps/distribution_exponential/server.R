server = function(input, output, session) {
  
teachingApps::add_server('distribution_exponential', envir = environment())

output$expfunc  <- renderUI({ teachingApps::add_rmd('exp-func.Rmd') })

output$expprops <- renderUI({ teachingApps::add_rmd('exp-props.Rmd') })
}