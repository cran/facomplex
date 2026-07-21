## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library(facomplex)
library(lavaan)
library(psych)
if (!requireNamespace("psych", quietly = TRUE)) {
  knitr::opts_chunk$set(eval = FALSE)
}
if (!requireNamespace("lavaan", quietly = TRUE)) {
  knitr::opts_chunk$set(eval = FALSE)
}

## -----------------------------------------------------------------------------
data(fullclean)

## -----------------------------------------------------------------------------
INV.target <- matrix(0, 12, 2)
INV.target[1:6, 1] <- NA
INV.target[7:12, 2] <- NA
INV.target

## -----------------------------------------------------------------------------
INV.esem.model <- '
efa("efa1")*f1 + 
efa("efa1")*f2 =~ INV1 + INV4 + INV5 + INV7 + INV11 + INV12 + INV3 + INV6 + INV8 + INV9 + INV13 + INV14
'

## -----------------------------------------------------------------------------
INV.esem.fit <- sem(INV.esem.model,
                    data = fullclean,
                    ordered = FALSE,
                    estimator = "ulsmv",
                    rotation = "target",
                    rotation.args = list(target = INV.target,
                                         geomin.epsilon = 0.01, 
                                         rstarts = 30,
                                         algorithm = "gpa",
                                         std.ov = TRUE))

## -----------------------------------------------------------------------------
summary(INV.esem.fit, standardized = TRUE, fit.measures = TRUE)

## -----------------------------------------------------------------------------
simload(data = lavInspect(INV.esem.fit, what = "std")$lambda,
    items_target = list(f1 = c(1,2,3,4,5,6), 
                        f2 = c(7,8,9,10,11,12)))

## -----------------------------------------------------------------------------
Hofmann(data = lavInspect(INV.esem.fit, what = "std")$lambda)

## -----------------------------------------------------------------------------
BSI(lavInspect(INV.esem.fit, what = "std")$lambda)

