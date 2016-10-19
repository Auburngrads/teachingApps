---
output: html_document
---

<h3>Functional relationships for <script type="math/tex">\;T \sim EXP(\theta,\gamma),\;\;T \in [0,\infty)</script>
</h3>
$$
\begin{aligned}
f(t|\theta,\gamma)&=\frac{1}{\theta}\exp\left(-\frac{t-\gamma}{\theta}\right)\\\\\\\\
F(t|\theta,\gamma)&=1-\exp\left(\frac{t-\gamma}{\theta}\right)\\\\\\\\
h(t|\theta,\gamma)&=\frac{1}{\theta}, t>\gamma\\\\\\\\\
t_{p}&=\gamma-\log(1-p)\theta\\\\\\\\
E[T]&=\gamma+\theta\\\\\\\\
Var[T]&=\theta^2
\end{aligned}
$$
