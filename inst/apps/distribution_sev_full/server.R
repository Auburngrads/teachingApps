server = function(input, output, session) {

teachingApps::nestServer('distribution_sev', envir = environment())  
  
output$sevfunc <- renderUI({ teachingApps::nestRmd('sev-func.Rmd') })

output$sevprops <- renderUI({ teachingApps::nestRmd('sev-props.Rmd') }) 
}