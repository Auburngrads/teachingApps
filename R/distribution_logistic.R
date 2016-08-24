distribution_logistic<- function() {

    app <- source(system.file("apps", "distribution_logistic.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
