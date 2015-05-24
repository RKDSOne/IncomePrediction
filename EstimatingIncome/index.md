---
title       : Using Machine Learning to predict Income
subtitle    : 
author      : Rajesh Korde
job         : Professional Woolgatherer
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Synopsis

* Social and professional characteristics of an individual are often good indicators of their annual income.
* This project uses a predictive model to estimate if a person earns more than 50,000 USD per year based on their age, gender, occupation etc.
* [A web front end](https://rajkorde.shinyapps.io/Shiny/) was created for the model using Shiny Apps. On the website, a user can enter their age, gender, occupation etc and the model would predict if their annual income is more than 50,000 USD or not. It also provides some descriptive statistics for the user.
* The model was trained using a 1994 data set from [UCI](https://archive.ics.uci.edu/ml/datasets/Adult).

----- 

## Dataset

* The training data set had 42830 rows, 9 predictors and 1 outcome variable.

```
## [1] 43830    10
```
* The following predictors are available to use in building the model. The outcome variable is whether the individual earns more than 50K USD a year.


```
## [1] "age"            "workclass"      "education"      "marital.status"
## [5] "occupation"     "relationship"   "race"           "sex"           
## [9] "hour.per.week"
```
* Since the data is from 1994, all predictions would also be only true for 1994.

-----

## Prediction Model

* Random Forest Algorithm is used to train the model on the data set described earlier.
* 10 fold cross validation was used for parameter tuning using the caret package. After turning, an mtry value of 28 was chosen for the final model.. 
* The metrics used to tune the model are Accuracy and Kappa. The final model had an Accuracy of 82.1% and a Kappa of 0.49 on cross validation data.
* The confusion matrix below shows the class accuracy.

```
##       <=50K >50K class.error
## <=50K 23825 2684   0.1012486
## >50K   3671 4885   0.4290556
```


-----

## Resources

* [Shiny App](https://rajkorde.shinyapps.io/Shiny/) for predicting Income.
* Adult data set is available from [UCI](https://archive.ics.uci.edu/ml/datasets/Adult)
* [Github repo](https://github.com/rajkorde/IncomePrediction)
* [Random Forest] (http://en.wikipedia.org/wiki/Random_forest)
* [Caret tuning] (http://topepo.github.io/caret/training.html)
