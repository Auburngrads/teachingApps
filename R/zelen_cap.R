zelen_cap<- function() {

    app <- source(system.file("apps", "zelen_cap.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
