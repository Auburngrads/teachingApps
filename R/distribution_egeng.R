distribution_egeng <- function() {

    file <- system.file("apps", "distribution_egeng.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
