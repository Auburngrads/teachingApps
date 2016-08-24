plotting_special <- function() {

    file <- system.file("apps", "plotting_special.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
