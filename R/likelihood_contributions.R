likelihood_contributions<- function() {

    app <- source(system.file("apps", "likelihood_contributions.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
