% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gl.collapse.pval.r
\name{gl.collapse.pval}
\alias{gl.collapse.pval}
\title{Collapse a fixed distance matrix by amalgamating populations for which pairwise fixed differences are not significant}
\usage{
gl.collapse.pval(
  fd,
  recode.table = "tmp.csv",
  outpath = tempdir(),
  delta = 0.02,
  reps = 1000,
  alpha = 0.05,
  plot = FALSE,
  verbose = NULL
)
}
\arguments{
\item{fd}{-- name of the list containing the collapsed gl object and associated distance matricies output by gl.collapse run with test=TRUE [required]}

\item{recode.table}{-- name of the new recode.table to receive the new population reassignments 
arising from the amalgamation of populations [tmp.csv]}

\item{outpath}{-- path where to save the output file [default tempdir(), mandated by CRAN]. Use outpath=getwd() or outpath="." when calling this function to direct output files to your working directory.}

\item{delta}{-- threshold for the level of difference between two populations that will be regarded as operationally fixed [Default 0.02]}

\item{reps}{number of repetitions in the simulations to estimate false positives. [Default 1000].}

\item{alpha}{-- significance level for test of false positives [default 0.05]}

\item{plot}{-- if TRUE, plot a PCoA with the new groupings [default FALSE]}

\item{verbose}{-- verbosity: 0, silent or fatal errors; 1, begin and end; 2, progress log ; 3, progress and results summary; 5, full report [default 2 or as specified using gl.set.verbosity]}
}
\value{
A list containing the gl object with the new collapsed populations and the following square matricies
        [[1]] $gl -- the input genlight object;
        [[2]] $fd -- raw fixed differences;
        [[3]] $pcfd -- percent fixed differences;
        [[4]] $nobs -- mean no. of individuals used in each comparison;
        [[5]] $nloc -- total number of loci used in each comparison;
        [[6]] $expobs -- the expected count of false positives for each comparison [by simulation], otherwise NAs
        [[7]] $prob -- the significance of the count of fixed differences [by simulation]. These should all be significant (< alpha)
}
\description{
This script takes the output from gl.collapse and further collapses the fixed difference matrix
based on the pvalue associated with each comparison. The results are subsets of populations (OTUs) for which
diagnosability is demonstrated in the sample set, but non-significant.
}
\author{
Arthur Georges (Post to \url{https://groups.google.com/d/forum/dartr})
}
