basic_dashboard<- function() {

    app <- source(system.file("apps", "basic_dashboard.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
