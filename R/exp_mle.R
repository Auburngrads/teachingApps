exp_mle<- function() {

    app <- source(system.file("apps", "exp_mle.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
