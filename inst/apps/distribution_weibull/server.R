server = function(input, output, session) {
  
     add_server('distribution_weibull_functions', env = environment())
  
output$weibfunc  <- renderUI({ add_rmd('weib-func.Rmd') })

output$weibprops <- renderUI({ add_rmd('weib-props.Rmd') }) 

}