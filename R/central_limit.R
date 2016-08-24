central_limit<- function() {

    app <- source(system.file("apps", "central_limit.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
