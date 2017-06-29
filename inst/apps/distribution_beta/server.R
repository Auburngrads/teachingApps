server = function(input, output, session) {

teachingApps::add_server('distribution_beta', envir = environment())  

output$betafunc <- renderUI({ teachingApps::add_rmd('beta-func.Rmd') })

output$betaprops <- renderUI({ teachingApps::add_rmd('beta-props.Rmd') }) 
}