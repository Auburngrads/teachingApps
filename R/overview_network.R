overview_network<- function() {

    app <- source(system.file("apps", "overview_network.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
