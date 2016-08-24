distribution_geng <- function() {

    file <- system.file("apps", "distribution_geng.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
