server = function(input, output, session) {

teachingApps::add_server('distribution_sev_functions', envir = environment())  
  
output$sevfunc <- renderUI({ teachingApps::add_rmd('sev-func.Rmd') })

output$sevprops <- renderUI({ teachingApps::add_rmd('sev-props.Rmd') }) 
}