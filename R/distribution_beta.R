distribution_beta<- function() {

    app <- source(system.file("apps", "distribution_beta.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
