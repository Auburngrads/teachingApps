ui = miniPage(gadgetTitleBar('MTBF Test Planning Tool'),
miniTabstripPanel(
  miniTabPanel('Visualize', icon = icon('area-chart'),
    miniContentPanel(           
        plotlyOutput('mtbf', height = '100%'))),
  
  miniTabPanel('Controls', icon = icon('sliders'),
    miniContentPanel(
        sliderInput('ttt', 
                    'Available Test Time', 
                     min = 100, 
                     max = 1000, 
                     step = 10, 
                     value = 400),
        sliderInput('fails', 
                    'Failures Allowed', 
                     min = 0, 
                     max = 30, 
                     step = 1, 
                     value = 1),
        sliderInput('thresh', 
                    'Threshold MTBF', 
                     min = 10, 
                     max = 500, 
                     step = 5, 
                     value = 40),
        sliderInput('objective', 
                    'Objective MTBF', 
                     min = 10, 
                     max = 500, 
                     step = 5, 
                     value = 70),
        sliderInput('contract', 
                    'Contract MTBF', 
                     min = 10, 
                     max = 500, 
                     step = 5, 
                     value = 90))),

  miniTabPanel('How To', icon = icon('map-o'),
    miniContentPanel(
        withMathJax(uiOutput("howtomtbf", class = 'ta-text')))),

  miniTabPanel('Examples', icon = icon('map-o'),
    miniContentPanel(
        uiOutput("examplemtbf", class = 'ta-text'))),

  miniTabPanel('Background', icon = icon('map-o'),
    miniContentPanel(
        uiOutput("backgroundmtbf", class = 'ta-text'))),

  miniTabPanel('About', icon = icon('map-o'),
    miniContentPanel(
        uiOutput("aboutmtbf", class = 'ta-text')))))

