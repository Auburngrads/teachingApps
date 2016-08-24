censored_eventplots<- function() {

    app <- source(system.file("apps", "censored_eventplots.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
