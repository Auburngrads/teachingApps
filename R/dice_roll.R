dice_roll<- function() {

    app <- source(system.file("apps", "dice_roll.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
