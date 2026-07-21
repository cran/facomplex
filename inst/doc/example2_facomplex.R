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
data(bfi, package = "psych")

## -----------------------------------------------------------------------------
fa.output <- psych::fa(bfi[, 1:10], 
                       nfactors = 2, 
                       rotate = "oblimin",
                       fm = "uls")

## -----------------------------------------------------------------------------
unclass(fa.output$loadings)
fa.load <- as.data.frame(unclass(fa.output$loadings))

## -----------------------------------------------------------------------------
Hofmann(fa.load)

## -----------------------------------------------------------------------------
BSI(fa.load)

## -----------------------------------------------------------------------------
KC(data = fa.load, b = 4)

## -----------------------------------------------------------------------------
simload(data = fa.load, 
    items_target = list(
      ULS1 = c(6,7,8,9,10), 
      ULS2 = c(1,2,3,4,5)
    ))

