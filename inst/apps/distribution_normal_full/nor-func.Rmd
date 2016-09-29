---
output: html_document
---

### Functional relationships for <script type="math/tex">\;Y \sim NOR(\mu,\sigma),\;\;Y\in(-\infty,\infty)</script>

$$
\begin{aligned}
f(y|\mu,\sigma)&=\frac{1}{\sigma}\phi_{nor}\left(\frac{y-\mu}{\sigma}\right)=\frac{1}{\sigma}\frac{e^{-(y - \mu)^{2}/(2\sigma^{2})}}{\sqrt{2\pi}}\\\\\\\\
F(y|\mu,\sigma)&=\Phi_{nor}\left(\frac{y-\mu}{\sigma}\right)=\int_{-\infty}^{y} \frac{e^{-(y-\sigma)^{2}/2\sigma^2}} {\sqrt{2\pi}\sigma}\\\\\\\\
h(y|\mu,\sigma)&=\frac{f(y|\mu,\sigma)}{1-F(y|\mu,\sigma)}\\\\\\\\
y_{p}&=\mu+\Phi^{-1}_{nor}(p)\sigma, \;\;\;\;\;\;\;\;\text{where}\;\Phi^{-1}_{nor}(p)=z_p\\\\\\\\
E[Y]&=\mu\\\\\\\\
Var[Y]&=\sigma^2
\end{aligned}
$$
