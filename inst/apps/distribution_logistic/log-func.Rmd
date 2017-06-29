---
output: html_document
---

### Functional relationships for <script type='math/tex'>Y \sim LOGIS(\mu,\sigma),\;\;Y\in(-\infty,\infty)</script>

$$
\begin{aligned}
f(y|\mu,\sigma)&=\frac{1}{\sigma}\phi_{logis}\left(\frac{y-\mu}{\sigma}\right)=\frac{1}{\sigma}\exp\left(\frac{y-\mu}{\sigma}\right)\left[1+\exp\left(\frac{y-\mu}{\sigma}\right)\right]^{-2}\\\\\\\\
F(y|\mu,\sigma)&=\Phi_{logis}\left(\frac{y-\mu}{\sigma}\right)=\exp\left(\frac{y-\mu}{\sigma}\right)\left[1+\exp\left(\frac{y-\mu}{\sigma}\right)\right]^{-1}\\\\\\\\
h(y|\mu,\sigma)&=\frac{1}{\sigma}\Phi_{logis}\left(\frac{y-\mu}{\sigma}\right)\\\\\\\\
y_{p}&=\mu+\Phi^{-1}_{logis}(p)\sigma, \;\;\;\;\;\;\;\;\text{where}\;\Phi^{-1}_{logis}(p)=\log [p/(1-p)]\\\\\\\\
E[Y]&=\mu\\\\\\\\
Var[Y]&=\sigma^2\pi^2/3
\end{aligned}
$$
