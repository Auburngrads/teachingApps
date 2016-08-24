distribution_geometric<- function() {

    app <- source(system.file("apps", "distribution_geometric.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
