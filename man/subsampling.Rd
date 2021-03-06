% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/subsampling.R
\name{subsampling}
\alias{subsampling}
\title{Multinomial sparse group lasso generic subsampling procedure}
\usage{
subsampling(x, classes, sampleWeights = NULL, grouping = NULL,
  groupWeights = NULL, parameterWeights = NULL, alpha = 0.5,
  standardize = TRUE, lambda, d = 100, training, test,
  intercept = TRUE, sparse.data = is(x, "sparseMatrix"),
  collapse = FALSE, max.threads = NULL, use_parallel = FALSE,
  algorithm.config = msgl.standard.config)
}
\arguments{
\item{x}{design matrix, matrix of size \eqn{N \times p}.}

\item{classes}{classes, factor of length \eqn{N}.}

\item{sampleWeights}{sample weights, a vector of length \eqn{N}.}

\item{grouping}{grouping of features (covariates), a vector of length \eqn{p}. Each element of the vector specifying the group of the feature.}

\item{groupWeights}{the group weights, a vector of length \eqn{m} (the number of groups).
If \code{groupWeights = NULL} default weights will be used.
Default weights are 0 for the intercept and
\deqn{\sqrt{K\cdot\textrm{number of features in the group}}}
for all other weights.}

\item{parameterWeights}{a matrix of size \eqn{K \times p}.
If \code{parameterWeights = NULL} default weights will be used.
Default weights are is 0 for the intercept weights and 1 for all other weights.}

\item{alpha}{the \eqn{\alpha} value 0 for group lasso, 1 for lasso, between 0 and 1 gives a sparse group lasso penalty.}

\item{standardize}{if TRUE the features are standardize before fitting the model. The model parameters are returned in the original scale.}

\item{lambda}{lambda.min relative to lambda.max or the lambda sequence for the regularization path (that is a vector or a list of vectors with the lambda sequence for the subsamples).}

\item{d}{length of lambda sequence (ignored if \code{length(lambda) > 1})}

\item{training}{a list of training samples, each item of the list corresponding to a subsample.
Each item in the list must be a vector with the indices of the training samples for the corresponding subsample.
The length of the list must equal the length of the \code{test} list.}

\item{test}{a list of test samples, each item of the list corresponding to a subsample.
Each item in the list must be vector with the indices of the test samples for the corresponding subsample.
The length of the list must equal the length of the \code{training} list.}

\item{intercept}{should the model include intercept parameters}

\item{sparse.data}{if TRUE \code{x} will be treated as sparse, if \code{x} is a sparse matrix it will be treated as sparse by default.}

\item{collapse}{if \code{TRUE} the results for each subsample will be collapse into one result (this is useful if the subsamples are not overlapping)}

\item{max.threads}{Deprecated (will be removed in 2018),
instead use \code{use_parallel = TRUE} and registre parallel backend (see package 'doParallel').
The maximal number of threads to be used.}

\item{use_parallel}{If \code{TRUE} the \code{foreach} loop will use \code{\%dopar\%}. The user must registre the parallel backend.}

\item{algorithm.config}{the algorithm configuration to be used.}
}
\value{
\item{link}{the linear predictors -- a list of length \code{length(test)} with each element of the list another list of length \code{length(lambda)} one item for each lambda value, with each item a matrix of size \eqn{K \times N} containing the linear predictors.}
\item{response}{the estimated probabilities -- a list of length \code{length(test)} with each element of the list another list of length \code{length(lambda)} one item for each lambda value, with each item a matrix of size \eqn{K \times N} containing the probabilities.}
\item{classes}{the estimated classes -- a list of length \code{length(test)} with each element of the list a matrix of size \eqn{N \times d} with \eqn{d=}\code{length(lambda)}.}
\item{features}{number of features used in the models.}
\item{parameters}{number of parameters used in the models.}
\item{classes.true}{ a list of length \code{length(training)}, containing the true classes used for estimation}
}
\description{
Multinomial sparse group lasso generic subsampling procedure using multiple possessors
}
\examples{
data(SimData)

# A quick look at the data
dim(x)
table(classes)

test <- list(1:20, 21:40)
train <- lapply(test, function(s) (1:length(classes))[-s])

# Run subsampling
# Using a lambda sequence ranging from the maximal lambda to 0.5 * maximal lambda
fit.sub <- msgl::subsampling(x, classes, alpha = 0.5, lambda = 0.5, training = train, test = test)

# Print some information
fit.sub

# Mean misclassification error of the tests
Err(fit.sub)

# Negative log likelihood error
Err(fit.sub, type="loglike")

}
\author{
Martin Vincent
}
