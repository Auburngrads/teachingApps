library(teachingApps)
library('networkD3')
library('d3Network')










  


shinyApp(options = list(height = '600px'),

ui = fluidPage(theme = shinythemes::shinytheme(theme = source('www/args.R')[[1]]$theme),
               try(includeCSS(system.file('css',
                                          'my-shiny.css', 
                                          package = 'teachingApps')), silent = T),
               
     mainPanel(networkD3::sankeyNetworkOutput('sankey1')),

fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(source('www/args.R')[[1]]$appName))})
         
 output$sankey1 <- networkD3::renderSankeyNetwork({
   

name <- c('Scraping Data', 'Cleaning Data', 'Analyzing Data', 'Summarizing Results', 'Visualizing Results')
nodes <- data.frame(name, stringsAsFactors = F)

source <- c('Scraping Data', 'Cleaning Data', 'Analyzing Data', 'Summarizing Results')
target <- c('Cleaning Data', 'Analyzing Data', 'Summarizing Results', 'Visualizing Results')
value  <- c(1,4,2,5)

links <- data.frame(source, target, value)

links2 <- merge(links,nodes,by.x = "source",by.y = "name")
#links2$source <-NULL
#names(links2) <- c("source","target","value")
links2 <- merge(links2,nodes,by.x = "target",by.y = "name")
#links2$target <- NULL
#names(links2) <- c("source","target","value")

d3Network::d3Sankey(Links = links, 
                         Nodes = nodes, 
                         Source = 'source', 
                         Target = 'target',
                         Value =  'value', NodeID = 'name',
                         nodeWidth = 3, width = 700)
})        
})
