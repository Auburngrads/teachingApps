distribution_levgets <- function() {

    file <- system.file("apps", "distribution_levgets.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
