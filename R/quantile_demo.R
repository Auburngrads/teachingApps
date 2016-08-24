quantile_demo <- function() {

    file <- system.file("apps", "quantile_demo.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
