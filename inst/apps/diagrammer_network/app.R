library(pos = -1,  package = 'DiagrammeR')











load('args.Rdata')
shinyApp(options = list(width = '100%'),
 
ui = fluidPage(theme = shinythemes::shinytheme(theme = get('theme')),
               try(includeCSS(system.file('css',
                                          'my-shiny.css', 
                                          package = 'teachingApps')), silent = T),
               
     sidebarLayout(
     sidebarPanel(width = 4),
     mainPanel(grVizOutput('grtest'))),

fixedPanel(htmlOutput('sign'),bottom = '9%', right = '40%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(basename(getwd())))})

    output$grtest <- renderGrViz({
    
grViz("
digraph dot {

graph [layout = circo, overlap=false]

node [shape = circle, style = filled, fillcolor = red, fontsize = 30, width = 2]
a [label = 'DATA\nSCIENCE']

node [shape = circle, fillcolor = green, fixedsize = TRUE, fontsize = 30, width = 2]
b [label = 'Getting\nData'] 
c [label = 'Analyzing\nData']
d [label = 'Presenting\nResults']

node [shape = plaintext, width = 0]
e [label = 'Web\nScraping']
f [label = 'Munging/\nCleaning']
g [label = 'Transforming']
h [label = 'Storing/\nSharing']

node [fillcolor = orange]
i [label = 'Bayesian\nTechniques']
j [label = 'Linear\nRegression']
k [label = 'Maximum\nLikelihood']
m [label = 'Stochastic\nProcesses']

edge [color = grey]
a -> {b c d}

edge [color = grey, weight = 1.5]
b -> {e f g h}
c -> {i j k m}
d -> {n o p q}
}")
})
})
