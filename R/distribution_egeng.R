distribution_egeng<- function() {

    app <- source(system.file("apps", "distribution_egeng.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
