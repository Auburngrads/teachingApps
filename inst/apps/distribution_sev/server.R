server = function(input, output, session) {

     add_server('distribution_sev_functions', env = environment())  
  
output$sevfunc <- renderUI({ add_rmd('sev-func.Rmd') })

output$sevprops <- renderUI({ add_rmd('sev-props.Rmd') }) 
}