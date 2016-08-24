plotting_basic <- function() {

    file <- system.file("apps", "plotting_basic.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
