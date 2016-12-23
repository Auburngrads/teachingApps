library(teachingApps)
library('plotly')
library('miniUI')

ui = miniPage(gadgetTitleBar('MTBF Test Planning Tool'),
miniTabstripPanel(
  miniTabPanel('Visualize', icon = icon('area-chart'),
    miniContentPanel(           
        plotlyOutput('mtbf', height = '100%'))),
  
  miniTabPanel('Controls', icon = icon('sliders'),
    miniContentPanel(
        sliderInput('ttt', h4('Available Test Time'), 
                     min = 100, 
                     max = 1000, 
                     step = 10, 
                     value = 400),
        sliderInput('fails', h4('Failures Allowed'), 
                     min = 0, 
                     max = 30, 
                     step = 1, 
                     value = 1),
        sliderInput('thresh', h4('Threshold MTBF'), 
                     min = 10, 
                     max = 500, 
                     step = 5, 
                     value = 40),
        sliderInput('objective', h4('Objective MTBF'), 
                     min = 10, 
                     max = 500, 
                     step = 5, 
                     value = 70),
        sliderInput('contract', h4('Contract MTBF'), 
                     min = 10, 
                     max = 500, 
                     step = 5, 
                     value = 90))),

  miniTabPanel('How To', icon = icon('map-o'),
    miniContentPanel(
        withMathJax(uiOutput("howtomtbf", class = 'shiny-text-output')))),

  miniTabPanel('Examples', icon = icon('map-o'),
    miniContentPanel(
        uiOutput("examplemtbf", class = 'shiny-text-output'))),

  miniTabPanel('Background', icon = icon('map-o'),
    miniContentPanel(
        uiOutput("backgroundmtbf", class = 'shiny-text-output'))),

  miniTabPanel('About', icon = icon('map-o'),
    miniContentPanel(
        uiOutput("aboutmtbf", class = 'shiny-text-output')))))

