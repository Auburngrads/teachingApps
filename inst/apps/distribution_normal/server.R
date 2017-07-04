server = function(input, output, session) {
  
teachingApps::add_server('distribution_normal_functions', envir = environment()) 
  
output$norfunc  <- renderUI({ teachingApps::add_rmd('nor-func.Rmd') })

output$norprops <- renderUI({ teachingApps::add_rmd('nor-props.Rmd') }) 
}