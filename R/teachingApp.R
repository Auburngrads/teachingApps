teachingApp <- function(app_name = NULL, 
                        theme = "flatly", 
                        width = '100%',
                        height = '800px',
                        icon = 'fa fa-github',
                        more.opts = list(NA),...)
{
  
    dir <- dirname(system.file("apps", app_name, "global.R", package = "teachingApps"))
  
    teachingApps::assign.shiny.opts(opts = more.opts,
                                    dir = dir,
                                    theme = theme,
                                    icon = icon)
    
    shiny::shinyAppDir(appDir = dir, 
                       options = list(height = height, width = width,...))

}