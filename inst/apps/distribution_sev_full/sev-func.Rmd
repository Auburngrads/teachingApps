---
output: html_document
---

### Functional relationships for <script type='math/tex'>Y \sim SEV(\mu,\sigma),\;\;Y\in(-\infty,\infty)</script>

$$
\begin{aligned}
f(y|\mu,\sigma)&=\frac{1}{\sigma}\phi_{sev}\left(\frac{y-\mu}{\sigma}\right)=\frac{1}{\sigma}e^{\left(\frac{t-\mu}{\sigma}\right)}e^{-e^{\left(\frac{t-\mu}{\sigma}\right)}}\\\\\\\\
F(y|\mu,\sigma)&=\Phi_{sev}\left(\frac{y-\mu}{\sigma}\right)=1-e^{-e^{\left(\frac{y-\mu}{\sigma}\right)}}\\\\\\\\
h(y|\mu,\sigma)&=\frac{1}{\sigma}\exp\left(\frac{y-\mu}{\sigma}\right)\\\\\\\\
y_{p}&=\mu+\Phi^{-1}_{sev}(p)\sigma, \;\;\;\;\;\;\text{where}\;\Phi^{-1}_{sev}(p)=\log[-\log(1-p)]\\\\\\\\
E[Y]&=\mu-\sigma\gamma, \;\;\;\;\;\;\;\;\;\;\;\; \text{where}\;\;\gamma\approx 0.5772\;\;\text{(Euler's Constant)}\\\\\\\\
Var[Y]&=\sigma^2\pi^2/6
\end{aligned}
$$
