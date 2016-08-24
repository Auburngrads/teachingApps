cdf_demo <- function() {

    file <- system.file("apps", "cdf_demo.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
