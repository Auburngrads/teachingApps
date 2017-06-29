---
output: html_document
---

### Functional relationships for <script type='math/tex'>T \sim LOGNOR(\mu,\sigma),\;\;T\in[0,\infty)</script>

$$
\begin{aligned}
f(t|\mu,\sigma)&=\frac{1}{\sigma}\phi_{nor}\left(\frac{\log(t)-\mu}{\sigma}\right)\\\\\\\\
F(t|\mu,\sigma)&=\Phi_{nor}\left(\frac{\log(t)-\mu}{\sigma}\right)\\\\\\\\
h(t|\mu,\sigma)&=\frac{f(t|\mu,\sigma)}{1-F(t|\mu,\sigma)}\\\\\\\\
t_{p}&=\exp\left[\mu+\Phi^{-1}_{nor}(p)\sigma\right], \;\;\;\;\;\;\;\;\text{where}\;\Phi^{-1}_{nor}(p)=z_p\\\\\\\\
E[T]&=\exp(\mu+0.5\sigma^2)\\\\\\\\
Var[T]&=\exp(2\mu+\sigma^2)(\exp(\sigma^2)-1)
\end{aligned}
$$

