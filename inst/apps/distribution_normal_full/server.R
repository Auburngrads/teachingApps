server = function(input, output, session) {
  
teachingApps::nestServer('distribution_normal', envir = environment()) 
  
output$norfunc  <- renderUI({ teachingApps::nestRmd('nor-func.Rmd') })

output$norprops <- renderUI({ teachingApps::nestRmd('nor-props.Rmd') }) 
}