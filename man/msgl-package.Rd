% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/msgl.R
\docType{package}
\name{msgl-package}
\alias{msgl-package}
\title{Multinomial logistic regression with sparse group lasso penalty.}
\description{
Simultaneous feature selection and parameter estimation for classification.
Suitable for high dimensional multiclass classification with many classes.
The algorithm computes the sparse group lasso penalized maximum likelihood estimate.
Use of parallel computing for cross validation and subsampling is supported through the \code{foreach} and \code{doParallel} packages.
Development version is on GitHub, please report package issues on GitHub.
}
\details{
For a classification problem with  \eqn{K} classes and \eqn{p} features (covariates) dived into \eqn{m} groups.
The multinomial logistic regression with sparse group lasso penalty estimator is a sequence of minimizers (one for each lambda given in the \code{lambda} argument) of
\deqn{\hat R(\beta) + \lambda \left( (1-\alpha) \sum_{J=1}^m \gamma_J \|\beta^{(J)}\|_2 + \alpha \sum_{i=1}^{n} \xi_i |\beta_i| \right)}
where \eqn{\hat R} is the weighted empirical log-likelihood risk of the multinomial regression model.
The vector \eqn{\beta^{(J)}} denotes the parameters associated with the \eqn{J}'th group of features
(default is one covariate per group, hence the default dimension of \eqn{\beta^{(J)}} is \eqn{K}).
The group weights \eqn{\gamma \in [0,\infty)^m} and parameter weights \eqn{\xi \in [0,\infty)^n} may be explicitly specified.
}
\examples{
# Load some data
data(PrimaryCancers)

# A quick look at the data
dim(x)
table(classes)

# A smaller subset with three classes 
small <- which(classes \%in\% c("CCA", "CRC", "Pancreas"))
classes <- classes[small, drop = TRUE]
x <- x[small, ]

#Do cross validation using 2 parallel units
cl <- makeCluster(2)
registerDoParallel(cl)

# Do 4-fold cross validation on a lambda sequence of length 100.
# The sequence is decreasing from the data derived lambda.max to 0.2*lambda.max
fit.cv <- msgl::cv(x, classes, fold = 4, lambda = 0.2, use_parallel = TRUE)

stopCluster(cl)

# Print information about models
# and cross validation errors (estimated expected generalization error)
fit.cv
}
\author{
Martin Vincent
}
