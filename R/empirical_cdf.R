empirical_cdf <- function() {

    file <- system.file("apps", "empirical_cdf.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
