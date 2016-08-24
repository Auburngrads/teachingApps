replace_plots <- function() {

    file <- system.file("apps", "replace_plots.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
