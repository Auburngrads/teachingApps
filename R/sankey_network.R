sankey_network<- function() {

    app <- source(system.file("apps", "sankey_network.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
