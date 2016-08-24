distribution_normal <- function() {

    file <- system.file("apps", "distribution_normal.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
