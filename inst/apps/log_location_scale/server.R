server = function(input, output, session) {

output$overview <- renderUI({ add_rmd('background.Rmd') })

######################
# Lognormal Server #
######################
output$lnorfunc <- renderUI({ 
  funcs_lnor <- system.file('apps','distribution_lognormal','lnor-func.Rmd', package = 'teachingApps')
  add_rmd(path = funcs_lnor)
})
output$lnorprops <- renderUI({
  props_lnor <- system.file('apps','distribution_lognormal','lnor-props.Rmd', package = 'teachingApps')
  add_rmd(path = props_lnor)
})

  add_server('distribution_lognormal_functions', env = environment())

######################
# Weibull Server #
######################
output$weibfunc <- renderUI({ 
  funcs_weib <- system.file('apps','distribution_weibull','weib-func.Rmd', package = 'teachingApps')
  add_rmd(path = funcs_weib)
})
output$weibprops <- renderUI({
  props_weib <- system.file('apps','distribution_weibull','weib-props.Rmd', package = 'teachingApps')
  add_rmd(path = props_weib)
})

  add_server('distribution_weibull_functions', env = environment())

######################
# Loglogistic Server #
######################
output$llogisfunc <- renderUI({ 
  funcs_llog <- system.file('apps','distribution_loglogistic','llog-func.Rmd', package = 'teachingApps')
  add_rmd(path = funcs_llog)
})
output$llogisprops <- renderUI({
  props_llog <- system.file('apps','distribution_loglogistic','llog-props.Rmd', package = 'teachingApps')
  add_rmd(path = props_llog)
})

  add_server('distribution_loglogistic_functions', env = environment())
}