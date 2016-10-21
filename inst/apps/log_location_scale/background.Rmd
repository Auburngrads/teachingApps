---
title: "Location-Scale and Log-Location-Scale Distributions"
output: html_document
---

### The Location-Scale Family of Distributions

- A random variable $Y$ belongs to the __location scale family__ if $F(Y)$ can be expressed as
$$P(Y\le y)=F(y|\mu, \sigma)=\Phi\left(\frac{y-\mu}{\sigma}\right)$$

- where

    + $\mu$ represents the location parameter, $\; \mu \in (-\infty,\infty)$

    + $\sigma$ represents the scale parameter, $\; \sigma \in [0,\infty)$

    + $\Phi$ represents the "standard" form of the cdf i.e. $\; (\mu, \sigma)=(0,1)$

- Many distributions belong to the location-scale family

    + Normal

    + Smallest extreme value

    + Largest extreme value

    + Logistic

- The statistical theory for the location-scale family is relatively simple

- Statistical methods developed for the location-scale family can be applied to any member distribution

    + <focus>This is a big deal</focus>

    + The more comfortable you become with location scale distributions, the better you will be at statistics

<br/>

### The Log-Location-Scale Family of Distributions

- $T$ belongs to the __log-location scale family__ if the cdf of $Y= \log(T)$ is a member of the location scale family
$$P(T\le t)=F(t|\mu, \sigma)=\Phi\left(\frac{\log(y)-\mu}{\sigma}\right)$$

- where

    + $\mu$ represents the location parameter, $\; \mu \in (-\infty,\infty)$

    + $\sigma$ represents the scale parameter, $\; \sigma \in [0,\infty)$

    + $\Phi$ represents the "standard" form of the cdf i.e. $\; (\mu, \sigma)=(0,1)$

- Many distributions can belong to the log-location-scale family

    + Lognormal

    + Weibull

    + Loglogistic

- Distributions in the log-location-scale family can be easily transformed to the location scale family using

$$Y = \log[T]$$

- where

    + $T$ is a member of the log-location-scale family

    + $Y$ is a member of the location-scale family
