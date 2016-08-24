ace_very_normal<- function() {

    app <- source(system.file("apps", "ace_very_normal.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
