diagrammer_network<- function() {

    app <- source(system.file("apps", "diagrammer_network.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
