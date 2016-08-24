distribution_sev<- function() {

    app <- source(system.file("apps", "distribution_sev.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
