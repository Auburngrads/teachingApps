htmlwidgets_shiny <- function() {

    file <- system.file("apps", "htmlwidgets_shiny.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
