plotting_positions <- function() {

    file <- system.file("apps", "plotting_positions.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
