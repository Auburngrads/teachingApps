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
              type = 'scatter',
              mode = 'lines',
              x = mtbf, 
              y = accept, 
              showlegend = F, 
              text = paste(
'Pr(accept) = ', round(accept, digits = 5),'<br>',
'True MTBF = ', mtbf,'<br>',
'Allowed Failures = ', input$fails,'<br>',
'Total Test Time = ', input$ttt),
              hoverinfo = 'markers+text')
p2 <- add_segments(p1,
                   x = input$thresh,
                   y = 0,
                   xend = input$thresh, 
                   yend = ppois(input$fails, input$ttt/input$thresh),
                   showlegend = F,
                   hoverinfo = 'none')
p3 <- add_segments(p2,
                   x = input$objective,
                   y = 0,
                   xend = input$objective, 
                   yend = ppois(input$fails, input$ttt/input$objective),
                   showlegend = F,
                   hoverinfo = 'none')
p4 <- add_segments(p3,
                   x = input$contract,
                   y = 0,
                   xend = input$contract, 
                   yend = ppois(input$fails, input$ttt/input$contract),
                   showlegend = F,
                   hoverinfo = 'none')
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
    output$howtomtbf <- renderUI({withMathJax(HTML(
'- Here are the equations 

<math xmlns="http://www.w3.org/1998/Math/MathML" display="block">
  <mtable columnalign="right left right left right left right left right left right left" rowspacing=".5em" columnspacing="0.278em 2em 0.278em 2em 0.278em 2em 0.278em 2em 0.278em 2em 0.278em">
    <mtr>
      <mtd>
        <mi>f</mi>
        <mo stretchy="false">(</mo>
        <mi>t</mi>
        <mrow class="MJX-TeXAtom-ORD">
          <mo stretchy="false">|</mo>
        </mrow>
        <mi>&#x03B8;<!-- <U+03B8> --></mi>
        <mo>,</mo>
        <mi>&#x03BA;<!-- <U+03BA> --></mi>
        <mo stretchy="false">)</mo>
      </mtd>
      <mtd>
        <mo>=</mo>
        <mfrac>
          <mn>1</mn>
          <mrow>
            <mi mathvariant="normal">&#x0393;<!-- G --></mi>
            <mo stretchy="false">(</mo>
            <mi>&#x03BA;<!-- <U+03BA> --></mi>
            <mo stretchy="false">)</mo>
            <mi>&#x03B8;<!-- <U+03B8> --></mi>
          </mrow>
        </mfrac>
        <msup>
          <mrow>
            <mo>(</mo>
            <mfrac>
              <mi>t</mi>
              <mi>&#x03B8;<!-- <U+03B8> --></mi>
            </mfrac>
            <mo>)</mo>
          </mrow>
          <mrow class="MJX-TeXAtom-ORD">
            <mi>&#x03BA;<!-- <U+03BA> --></mi>
            <mo>&#x2212;<!-- - --></mo>
            <mn>1</mn>
          </mrow>
        </msup>
      </mtd>
    </mtr>
    <mtr>
      <mtd />
    </mtr>
    <mtr>
      <mtd>
        <mi>F</mi>
        <mo stretchy="false">(</mo>
        <mi>t</mi>
        <mrow class="MJX-TeXAtom-ORD">
          <mo stretchy="false">|</mo>
        </mrow>
        <mi>&#x03B8;<!-- <U+03B8> --></mi>
        <mo>,</mo>
        <mi>&#x03BA;<!-- <U+03BA> --></mi>
        <mo stretchy="false">)</mo>
      </mtd>
      <mtd>
        <mo>=</mo>
        <msub>
          <mi mathvariant="normal">&#x0393;<!-- G --></mi>
          <mrow class="MJX-TeXAtom-ORD">
            <mi>I</mi>
          </mrow>
        </msub>
        <mrow>
          <mo>(</mo>
          <mfrac>
            <mi>t</mi>
            <mi>&#x03B8;<!-- <U+03B8> --></mi>
          </mfrac>
          <mo>,</mo>
          <mi>&#x03BA;<!-- <U+03BA> --></mi>
          <mo>)</mo>
        </mrow>
      </mtd>
    </mtr>
    <mtr>
      <mtd />
    </mtr>
    <mtr>
      <mtd>
        <msub>
          <mi>t</mi>
          <mrow class="MJX-TeXAtom-ORD">
            <mi>p</mi>
          </mrow>
        </msub>
      </mtd>
      <mtd>
        <mo>=</mo>
        <mi>&#x03B8;<!-- <U+03B8> --></mi>
        <msubsup>
          <mi mathvariant="normal">&#x0393;<!-- G --></mi>
          <mrow class="MJX-TeXAtom-ORD">
            <mi>I</mi>
          </mrow>
          <mrow class="MJX-TeXAtom-ORD">
            <mo>&#x2212;<!-- - --></mo>
            <mn>1</mn>
          </mrow>
        </msubsup>
        <mo stretchy="false">(</mo>
        <mi>p</mi>
        <mo>,</mo>
        <mi>&#x03BA;<!-- <U+03BA> --></mi>
        <mo stretchy="false">)</mo>
      </mtd>
    </mtr>
    <mtr>
      <mtd />
    </mtr>
    <mtr>
      <mtd>
        <mi>E</mi>
        <mo stretchy="false">[</mo>
        <mi>T</mi>
        <mo stretchy="false">]</mo>
      </mtd>
      <mtd>
        <mo>=</mo>
        <mi>&#x03BA;<!-- <U+03BA> --></mi>
        <mi>&#x03B8;<!-- <U+03B8> --></mi>
      </mtd>
    </mtr>
    <mtr>
      <mtd />
    </mtr>
    <mtr>
      <mtd>
        <mi>V</mi>
        <mi>a</mi>
        <mi>r</mi>
        <mo stretchy="false">[</mo>
        <mi>T</mi>
        <mo stretchy="false">]</mo>
      </mtd>
      <mtd>
        <mo>=</mo>
        <mi>&#x03BA;<!-- <U+03BA> --></mi>
        <msup>
          <mi>&#x03B8;<!-- <U+03B8> --></mi>
          <mn>2</mn>
        </msup>
      </mtd>
    </mtr>
  </mtable>
</math>'))
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

<li>The inherently stochastic behavior of real-world systems admits the possibility that an acceptable system may fail during the limited test period.  Similarly, a truly unacceptable system may pass. For this reason it is critical that the sampling plan be properly scoped to address these risks. Sizing an OC plan requires two risk variables, alpha and beta (numbers between 0 and 1). Alpha is also called consumer's risk and indicates the probability that the consumer observes the requisite number of failures (or less) and accepts a system that is actually below threshold (1-alpha is called confidence). Beta is also called producer's risk and indicates the probability that the producer's truly acceptable system results in too many failures and is rejected (1-beta is called power). Balancing these risks on an OC curve requires both lower bound (acquisition system threshold) and goal (acquisition system objective) values to properly determine a sampling plan. DoD acquisition policy defines the threshold (T) as 'the minimum acceptable operational value??? and objective (O) values as ?the desired operational goal.'  In some cases the objective value may be the same as the threshold.  The contracted performance value can be used in lieu of an objective value.  These details will be demonstrated later graphically</li>

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

<li>The inherently stochastic behavior of real-world systems admits the possibility that an acceptable system may fail during the limited test period.  Similarly, a truly unacceptable system may pass. For this reason it is critical that the sampling plan be properly scoped to address these risks. Sizing an OC plan requires two risk variables, alpha and beta (numbers between 0 and 1). Alpha is also called consumer's risk and indicates the probability that the consumer observes the requisite number of failures (or less) and accepts a system that is actually below threshold (1-alpha is called confidence). Beta is also called producer's risk and indicates the probability that the producer's truly acceptable system results in too many failures and is rejected (1-beta is called power). Balancing these risks on an OC curve requires both lower bound (acquisition system threshold) and goal (acquisition system objective) values to properly determine a sampling plan. DoD acquisition policy defines the threshold (T) as 'the minimum acceptable operational value??? and objective (O) values as ?the desired operational goal.'  In some cases the objective value may be the same as the threshold.  The contracted performance value can be used in lieu of an objective value.  These details will be demonstrated later graphically</li>

<li>For a given alpha and beta, test time increases as T and O get closer together.  Realistic values with a meaningful difference between them will reduce the test time required to make an accurate assessment</li>
</ul>
</ul>")
})
}