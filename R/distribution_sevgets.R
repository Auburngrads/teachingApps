distribution_sevgets<- function() {

    app <- source(system.file("apps", "distribution_sevgets.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
