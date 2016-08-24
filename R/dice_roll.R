dice_roll <- function() {

    file <- system.file("apps", "dice_roll.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
