acceptance_mtbf <-
function(...) {

try(attachNamespace('shiny'), silent = TRUE)
try(attachNamespace('plotly'), silent = TRUE)

shinyApp(options = list(height = '800px', width = '99%'),
         
    ui = navbarPage(theme = shinythemes::shinytheme('flatly'), 
                    try(includeCSS(system.file('css',
                                           'my-shiny.css', 
                                           package = 'teachingApps')), silent = T),
          
tabPanel(h4('MTBF Test Planning Tool'),
         sidebarLayout(
           sidebarPanel(width = 3,
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
                          value = 90)),
           mainPanel(plotlyOutput('mtbf', height = '650px'),width = 9))),

tabPanel(h4('How To Use The Tool'),

        mainPanel(uiOutput("howtomtbf", class = 'shiny-text-output'), width = 12)),

tabPanel(h4('Examples'),

        mainPanel(uiOutput("examplemtbf", class = 'shiny-text-output'), width = 12)),

tabPanel(h4('Background'),

        mainPanel(uiOutput("backgroundmtbf", class = 'shiny-text-output'), width = 12)),

tabPanel(h4('About'),

        mainPanel(uiOutput("aboutmtbf", class = 'shiny-text-output'), width = 12))),

server = function(input, output, session) {
  
  output$mtbf <- renderPlotly({

mtbf <- seq(1,500,1)
accept <- ppois(input$fails, input$ttt/mtbf)
datas <- data.frame(mtbf, accept) 

observe({

if(input$thresh>=input$objective) { 

   updateSliderInput(session, "objective", value = input$thresh+5) } 

if(input$objective>=input$contract) { 

   updateSliderInput(session, "contract", value = input$objective+5) }
  
})

p1 <- plot_ly(datas, 
              x = mtbf, 
              y = accept, 
              showlegend = T, 
              name = 'Pr(accept)', 
              text = paste(
'Pr(accept) = ', round(accept, digits = 5),'<br>',
'True MTBF = ', mtbf,'<br>',
'Allowed Failures = ', input$fails,'<br>',
'Total Test Time = ', input$ttt),
              hoverinfo = 'markers+text')
p2 <- add_trace(p1,
                x = rep(input$thresh,2), 
                y = c(0,ppois(input$fails, input$ttt/input$thresh)),
                showlegend = T,
                name = 'Threshold',
                hoverinfo = 'text',
                marker = list(size = 10, color = 'orange'))
p3 <- add_trace(p2,
                x = rep(input$objective,2), 
                y = c(0,ppois(input$fails, input$ttt/input$objective)),
                showlegend = T,
                name = 'Objective',
                hoverinfo = 'text',
                marker = list(size = 10, color = 'green'))
p4 <- add_trace(p3,
                x = rep(input$contract,2), 
                y = c(0,ppois(input$fails, input$ttt/input$contract)),
                showlegend = T,
                name = 'Contract',
                hoverinfo = 'text',
                marker = list(size = 10, color = 'red'))
p5 <- 
  layout(p4,
         yaxis = list(title = "Probability of Acceptance - Pr(accept)",
                      range = extendrange(c(0,ppois(input$fails,
                                                    input$ttt/input$contract)*1.25)),
                      titlefont = list(size = 16)),
         xaxis = list(title = 'True System Reliability - MTBF',
                      range = extendrange(c(input$thresh,input$contract), f = .5),
                      titlefont = list(size = 16)),
             
             annotations = list(
               list(x = c(input$thresh),
                    y = ppois(input$fails, input$ttt/input$thresh),
                    text = 'Threshold ',
                    showarrow = T,
                    ay = -40,
                    ax = -40,
                    arrowhead = 0,
                    arrowcolor = 'orange'),
               list(x = input$objective,
                    y = ppois(input$fails, input$ttt/input$objective),
                    text = "Objective",
                    showarrow = T,
                    ay = -60,
                    ax = -50,
                    arrowhead = 0,
                    arrowcolor = 'green'),
               list(x = input$contract,
                    y = ppois(input$fails, input$ttt/input$contract),
                    text = "Contract",
                    showarrow = T,
                    ay = -80,
                    ax = -60,
                    arrowhead = 0,
                    arrowcolor = 'red')),
             font = list(size = 16))
})
    output$howtomtbf <- renderUI({HTML(
'<li>R, like most languages, does not maximize functions - but <red>minimizes</red> them</li>

<li>Therefore, to find `maximum` values we minimize the <u>negative</u> of a function</li>

<center><p><focus>This is why the <code>joint.exp()</code> returns a negative<focus></p></center>

<li>This does not change the value of the point at which the maximum value occurs (returned by <code>$par</code>)</li>  

<li>But, we must remember that the value of the likelihood function (returned by <code>$objective</code>) must be multiplied by -1</li>')
})
    output$examplemtbf <- renderUI({HTML(
'<li>R, like most languages, does not maximize functions - but <red>minimizes</red> them</li>

<li>Therefore, to find `maximum` values we minimize the <u>negative</u> of a function</li>

<center><p><focus>This is why the <code>joint.exp()</code> returns a negative<focus></p></center>

<li>This does not change the value of the point at which the maximum value occurs (returned by <code>$par</code>)</li>  

<li>But, we must remember that the value of the likelihood function (returned by <code>$objective</code>) must be multiplied by -1</li>')
})
    
    output$backgroundmtbf <- renderUI({HTML(
"<h1>Mathematical Background for this Tool</h1>

<ol>
<li>Details regarding the mathematics and use of OC curves can be found in many texts and references including</li>
<ul>
<li>Kensler (2014)</li> 
<li>Truett (2013)</li>
</ul>

<li>This tool should be used in place of the paper binomial nomograph for correct test planning (Harman 2013)</li>

<li>The following are some key points are worth restating outside of the details available in these references</li>


<li>OC calculations assume the sampling is done from a single population, meaning the test time should be applied to a single configuration. However, configurations usually change during developmental testing (DT). <focus>So, the test time planning that OC curves provide is a baseline for initial resource planning</focus></li>

<li>The calculations in this tool are based on a hypothesis test where</li>

<font style='margin:0 0 0 20%;'>H<sub>0</sub>: System reliabilty <u>does not meet</u> the threshold value</font><br> 

<font style='margin:0 0 0 20%;'>H<sub>A</sub>: System reliability <u>does meet</u> the threshold value</font><br>  

<ul>
<li><focus>This is what we want to prove with the test being planned</focus></center></li>

<li>We will reject the null hypothesis (system passes) if the specified test time results in the allowed number of failures or less</li> 

<li>We will not reject the null hypothesis (system fails) if requisite number of failures is exceeded</li>
</ul>

<li>A 'point estimate' is the simple calculation of the proportion (number of successes divided by total number of trials) or mean-time (total time divided by number of failures). Uncertainty in our estimate results in a parameter estimate (confidence) interval whose width is determined by the sampling plan parameters. The tool described herein is set up with the lower bound of the point estimate set at the threshold</li>

<li>The inherently stochastic behavior of real-world systems admits the possibility that an acceptable system may fail during the limited test period.  Similarly, a truly unacceptable system may pass. For this reason it is critical that the sampling plan be properly scoped to address these risks. Sizing an OC plan requires two risk variables, alpha and beta (numbers between 0 and 1). Alpha is also called consumer's risk and indicates the probability that the consumer observes the requisite number of failures (or less) and accepts a system that is actually below threshold (1-alpha is called confidence). Beta is also called producer's risk and indicates the probability that the producer's truly acceptable system results in too many failures and is rejected (1-beta is called power). Balancing these risks on an OC curve requires both lower bound (acquisition system threshold) and goal (acquisition system objective) values to properly determine a sampling plan. DoD acquisition policy defines the threshold (T) as 'the minimum acceptable operational value? and objective (O) values as ?the desired operational goal.'  In some cases the objective value may be the same as the threshold.  The contracted performance value can be used in lieu of an objective value.  These details will be demonstrated later graphically</li>

<li>For a given alpha and beta, test time increases as T and O get closer together.  Realistic values with a meaningful difference between them will reduce the test time required to make an accurate assessment</li>
</ol>")
})
    output$aboutmtbf <- renderUI({HTML(
"<ul>
<li>Some key points are worth restating outside of the details available in these references</li>

<ul>
<li>OC calculations assume the sampling is done from a single population, meaning the test time should be applied to a single configuration. However, configurations usually change during developmental testing (DT). So, the test time planning that OC curves provide is a baseline for initial resource planning</li>

<li>OC curves are a simple way to plan reliability testing and are based on a single hypothesis test.  The calculations in this tool assume a null hypothesis that the system does not perform to threshold and the alternate (what we aim to prove) is that it does at least meet threshold.  We will reject the null (system passes) if the specified test time results in the allowed number of failures or less. Whereas, the null is not rejected (system fails) if requisite number of failures is exceeded</li>

<li>A 'point estimate' is the simple calculation of the proportion (number of successes divided by total number of trials) or mean-time (total time divided by number of failures). Uncertainty in our estimate results in a parameter estimate (confidence) interval whose width is determined by the sampling plan parameters. The tool described herein is set up with the lower bound of the point estimate set at the threshold</li>

<li>The inherently stochastic behavior of real-world systems admits the possibility that an acceptable system may fail during the limited test period.  Similarly, a truly unacceptable system may pass. For this reason it is critical that the sampling plan be properly scoped to address these risks. Sizing an OC plan requires two risk variables, alpha and beta (numbers between 0 and 1). Alpha is also called consumer's risk and indicates the probability that the consumer observes the requisite number of failures (or less) and accepts a system that is actually below threshold (1-alpha is called confidence). Beta is also called producer's risk and indicates the probability that the producer's truly acceptable system results in too many failures and is rejected (1-beta is called power). Balancing these risks on an OC curve requires both lower bound (acquisition system threshold) and goal (acquisition system objective) values to properly determine a sampling plan. DoD acquisition policy defines the threshold (T) as 'the minimum acceptable operational value? and objective (O) values as ?the desired operational goal.'  In some cases the objective value may be the same as the threshold.  The contracted performance value can be used in lieu of an objective value.  These details will be demonstrated later graphically</li>

<li>For a given alpha and beta, test time increases as T and O get closer together.  Realistic values with a meaningful difference between them will reduce the test time required to make an accurate assessment</li>
</ul>
</ul>")
})
})
}
