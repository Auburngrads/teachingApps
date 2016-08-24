distribution_loglogistic<- function() {

    app <- source(system.file("apps", "distribution_loglogistic.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
