distribution_lev <- function() {

    file <- system.file("apps", "distribution_lev.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
