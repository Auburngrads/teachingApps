server = function(input, output, session) {

output$overview <- renderUI({ add_rmd('background.Rmd') })

######################
# Exponential Server #
######################
output$expfunc <- renderUI({
  funcs_exp <- system.file('apps','distribution_exponential','exp-func.Rmd', package = 'teachingApps')
  add_rmd(path = funcs_exp)
})
output$expprops <- renderUI({
  props_exp <- system.file('apps','distribution_exponential','exp-props.Rmd', package = 'teachingApps')
   add_rmd(path = props_exp)
})

   add_server('distribution_exponential_functions', env = environment())

#################
# Normal Server #
#################
output$norfunc <- renderUI({
   funcs_nor <- system.file('apps','distribution_normal','nor-func.Rmd', package = 'teachingApps')
   add_rmd(path = funcs_nor)
})
output$norprops <- renderUI({
   props_nor <- system.file('apps','distribution_normal','nor-props.Rmd', package = 'teachingApps')
   add_rmd(path = props_nor)
})
        add_server('distribution_normal_functions', env = environment())

##############
# SEV Server #
##############
output$sevfunc <- renderUI({
   funcs_sev <- system.file('apps','distribution_normal','sev-func.Rmd', package = 'teachingApps')
   add_rmd(path = funcs_sev)

})
output$sevprops <- renderUI({
   props_sev <- system.file('apps','distribution_sev','sev-props.Rmd', package = 'teachingApps')
   add_rmd(path = props_sev)
})
        add_server('distribution_sev_functions', env = environment())

##############
# LEV Server #
##############
output$levfunc <- renderUI({
  funcs_lev <- system.file('apps','distribution_lev','lev-func.Rmd', package = 'teachingApps')
  add_rmd(path = funcs_lev)

})
output$levprops <- renderUI({
   props_lev <- system.file('apps','distribution_lev','lev-props.Rmd', package = 'teachingApps')
   add_rmd(path = props_lev)
})
        add_server('distribution_lev_functions', env = environment())

###################
# Logistic Server #
###################
output$logisfunc <- renderUI({
   funcs_logis <- system.file('apps','distribution_logistic','log-func.Rmd', package = 'teachingApps')
   add_rmd(path = funcs_logis)

})
output$logisprops <- renderUI({
   props_logis <- system.file('apps','distribution_logistic','log-props.Rmd', package = 'teachingApps')
   add_rmd(path = props_logis)
})

        add_server('distribution_logistic_functions', env = environment())
}