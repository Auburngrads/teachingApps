distribution_lognormal <- function() {

    file <- system.file("apps", "distribution_lognormal.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
