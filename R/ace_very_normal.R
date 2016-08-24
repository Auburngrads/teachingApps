ace_very_normal <- function() {

    file <- system.file("apps", "ace_very_normal.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
