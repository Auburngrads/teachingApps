arg2 <-
structure(list(theme = "flatly", appDir = "myAppDir", appName = "myApp"), .Names = c("theme", 
"appDir", "appName"), row.names = c(NA, -1L), class = "data.frame")

objs <- function(main.css = getShinyOption("CSS"),
                 user.css = getShinyOption("css"),
                 sign = getShinyOption("appName")) {
  
  return(insertUI('html', 'beforeEnd',
         ui = list(tags$head(includeCSS(main.css)),
                   tags$head(includeCSS(user.css)),
                   tags$footer(HTML(teachingApps::signature(sign))))))
}