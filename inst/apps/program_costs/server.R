server = function(input, output, session) {
  
  output$buyer  <- renderPlot({
    
    N <- input$nsamples
    
#data <- matrix(NA, N, 1)
count = 0
#for(j in 1:N)
#{
  #lognormal distribution with a sample size of N
  set.seed(input$seed)
  weight <- rlnorm(N,log(2000),0.198)
  
  #beta distribution with sample size of N
  
  unit.cost <- rbeta(N,199.5,199.5) * 40
  
  #normal distribution with sample size of N
  
  efficiency <- rnorm(N,1.6,0.2)
  
  #combine to find the total cost
  
  total.cost <- (weight * unit.cost) / sqrt(efficiency)
#  data[j,1] <- total.cost
#}
data.log <- total.cost >= input$threshold
prob <- round(sum(data.log) / N, digits = 4)
#print(prob)
hist(total.cost, 
     xlab = "Total Program Operating Cost (U.S. Dollars)", 
     main = "", 
     breaks = input$breaks, 
     las = 1, 
     col = scales::alpha('blue',.3), 
     cex.axis = 1.2, 
     cex.lab = 1.2,
     mgp = c(3.25,.5, 0), 
        tcl = -0.3, 
        font.lab = 2, 
        font = 2, 
        font.axis = 2, 
        las = 1, 
        tck = 0.015,
     mar = c(4.1, 4.1, .1, 1.1),
     xlim = c(10000,80000))
abline(v=input$threshold, col = rgb(red = prob-0,green = 1-prob,blue = 0), lwd = 3)
mtext(side = 3,
      at = input$threshold,
      text = if(input$threshold<50000) { 
                    substitute(a%<-%b~Pr(cost>=c)~'='~d, 
                               list(a = ' ', b = '', c = paste(c('$',input$threshold), collapse = ''), d = prob)) 
        } else {
                    substitute(Pr(cost>=c)~'='~d~a%->%b, 
                               list(a = '', b = '', c = paste(c('$',input$threshold), collapse = ''), d = prob)) },
      font = 2,
      adj = if(input$threshold<50000) {0} else {1},
      padj = .75,
      cex = 2,
      line = 0,
      col = rgb(red = prob-0,green = 1-prob,blue = 0) )
})
output$howtohist <- renderUI({withMathJax(HTML(
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
}