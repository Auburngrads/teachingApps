program_costs<- function() {

    app <- source(system.file("apps", "program_costs.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
