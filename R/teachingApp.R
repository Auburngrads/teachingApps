#' Render a teachingApp With Options
#'
#' @description Renders a teachingApp as a stand-alone shiny app
#'     or as an element within an rmarkdown document. 
#'
#' @importFrom shinythemes shinytheme
#' @importFrom shinyAce aceEditor
#' @importFrom diagram plotmat
#' @importFrom utils View combn
#' @importFrom pacman p_load
#' @importFrom dygraphs dygraph renderDygraph dySeries dygraphOutput
#' @importFrom leaflet leafletOutput leaflet addTiles addMarkers renderLeaflet
#' @importFrom threejs renderGlobe globejs globeOutput
#' @importFrom d3heatmap d3heatmap renderD3heatmap d3heatmapOutput
#' @importFrom grDevices rgb rainbow heat.colors terrain.colors cm.colors extendrange
#' @importFrom scales alpha
#' @importFrom networkD3 renderSankeyNetwork sankeyNetworkOutput
#' @importFrom radarchart chartJSRadarOutput renderChartJSRadar chartJSRadar
#' @importFrom DT datatable dataTableOutput renderDataTable
#' @importFrom actuar pllogis dllogis qllogis rllogis
#' @importFrom dplyr summarise group_by arrange desc select filter ungroup mutate
#' @importFrom tidyr gather spread
#' @importFrom DiagrammeR grVizOutput renderGrViz grViz
#' @importFrom visNetwork visNetwork addFontAwesome visOptions visNodes visInteraction renderVisNetwork visNetworkOutput
#' @importFrom plotly plotlyOutput renderPlotly plot_ly add_segments layout toRGB
#' @importFrom miniUI miniPage gadgetTitleBar miniTabPanel miniContentPanel
#' @importFrom shinydashboard dashboardPage dashboardSidebar dashboardBody infoBox infoBoxOutput renderInfoBox
#' @importFrom ggplot2 ggplot aes theme_light geom_line
#' @importFrom graphics polygon par box boxplot pie plot mtext abline axis legend points text grid lines segments curve
#' @importFrom metricsgraphics metricsgraphicsOutput renderMetricsgraphics mjs_plot mjs_line mjs_labs mjs_add_css_rule mjs_add_line
#' @importFrom shiny fixedPanel uiOutput HTML htmlOutput sidebarLayout renderUI titlePanel
#' @importFrom shiny brushedPoints brushOpts br hr checkboxInput div invalidateLater
#' @importFrom shiny fixedPanel uiOutput HTML htmlOutput sidebarLayout tags renderUI 
#' @importFrom shiny sidebarPanel mainPanel fluidPage navbarPage tabPanel h2 h4 validateCssUnit
#' @importFrom shiny tabsetPanel withMathJax updateSelectInput updateSliderInput textOutput
#' @importFrom shiny updateNumericInput strong stopApp shinyAppDir downloadHandler
#' @importFrom shiny radioButtons clickOpts runApp helpText h1 h5 h6 includeCSS
#' @importFrom shiny includeScript includeMarkdown inputPanel isolate nearPoints
#' @importFrom shiny observe observeEvent reactiveValues reactive renderText selectInput
#' @importFrom shiny actionButton selectizeInput plotOutput renderPlot fillRow fillCol
#' @import     datasets
#'
#' @param app_name \code{character} Name of the app to be rendered
#' @param theme \code{character} Name of a bootswatch color theme (provided by \code{shinythemes::shinytheme})
#' @param width \code{character} The width of the printed app (in pixels)
#' @param height \code{character} The height of the printed app (in pixels)
#' @param icon  \code{character} A fontAwesome icon to be placed in the footer of a navbarPage app
#' @param img \code{character} A path (or URL) to an image to be placed in the footer of a navbarPage app
#' @param git_user \code{character} GitHub username used in the branding logo
#' @param more_opts A \code{list} of additional options/objects that can be passed to the app (see Details)
#' @param launch.browser \code{logical} If \code{TRUE} The app launches in the user's default browser
#' @param ... A \code{list} of additional options passed to \code{shiny::shinyAppDir()} 
#' 
#' @return A printed shiny app
#' @export
#' @details The \code{teachingApps} package provides an infrastructure 
#'    that allows users to dynamically change the appearance and function of
#'    shiny apps. R users a familiar with writing functions to dynamically alter 
#'    some output - in this case the output is a app.  Normally, 
#'
#' @seealso code{link{create_logo}}
#' @seealso code{link{add_logo}}
#' @examples 
#' \dontrun{
#' teachingApps(app_name = 'distribution_weibull', 
#'              theme = 'spacelab', 
#'              height = '800px')
#' 
#' teachingApps(app_name = 'maximum_likelihood_simulation',
#'              theme = 'flatly',
#'              height = '600px')
#' }
teachingApp <- 
function(app_name = NULL, 
         theme = 'flatly',
         width = '100%',
         height = '800px',
         icon = 'fa fa-github',
         img = NULL,
         git_user = 'Auburngrads',
         more_opts = list(NA),
         launch.browser = TRUE,...)
{
 
    valid_apps <- list.files(system.file("apps", package = "teachingApps"))

    valid_apps_df <- data.frame(valid_apps)
    colnames(valid_apps_df) <- 'Valid teachingApps'
    
    if (missing(app_name) || !nzchar(app_name) || !app_name %in% valid_apps) {
      
    stop(paste0('Please run `teachingApp()` with a valid app as an argument.\n',
                 "See table for Valid teachingApps"),
         utils::View(valid_apps_df),
         call. = FALSE)
    }
    
   
    dir <- system.file('apps', app_name, package = 'teachingApps')
  
    teachingApps::add_options(opts = more_opts,
                              dir = dir,
                              theme = theme,
                              icon = icon,
                              img = img,
                              git_user = git_user)
    
    shiny::shinyAppDir(appDir = dir, 
                       options = list(height = height, 
                                      width = width,
                                      launch.browser = launch.browser,...))

}