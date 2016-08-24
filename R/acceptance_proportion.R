acceptance_proportion<- function() {

    app <- source(system.file("apps", "acceptance_proportion.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
