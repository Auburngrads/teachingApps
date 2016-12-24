server = function(input, output, session) {
  
teachingApps::nestServer('distribution_beta', envir = environment())
  
output$levfunc  <- renderUI({teachingApps::nestRmd('lev-func.Rmd') })

output$levprops <- renderUI({teachingApps::nestRmd('lev-props.Rmd') }) 
}