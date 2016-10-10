---
output: html_document
---

### Example 1.1 - Ball Bearing Fatigue Test (Liebling & Zelen, 1956)

- Motivation for the study

    - Fatigue affects the service life of deep-groove ball bearings

    - Applying higher levels of stress further reduces the fatigue life of the ball bearings    

    - There was disagreement within the industry on the appropriate parameter values to use to model the affect of applied stress on fatigue life 

- Study objectives

    - Test several ball bearings at a key stress level to augment the existing failure data

    - The additional observations should result in better estimates of the parameter values used to model fatigue life as a function of the applied stress in deep-groove ball bearings

- Data Set (Table 1.1) `lzbearing`

    - The data are the observed number of accumulated fatigue cycles when each fatigue failure occurred 

    - The data are reported in millions of cycles for $n = 23$ bearings 

    - We aren't told what stress was applied to each bearing in this test 

    - We must assume that the stress applied to all 23 bearings was equivalent
