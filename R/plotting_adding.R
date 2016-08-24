plotting_adding <- function() {

    file <- system.file("apps", "plotting_adding.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
