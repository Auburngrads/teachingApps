server = function(input, output, session) {

teachingApps::nestServer('distribution_beta', envir = environment())  

output$betafunc <- renderUI({ teachingApps::nestRmd('beta-func.Rmd') })

output$betaprops <- renderUI({ teachingApps::nestRmd('beta-props.Rmd') }) 
}