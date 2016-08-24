plotting_par <- function() {

    file <- system.file("apps", "plotting_par.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
