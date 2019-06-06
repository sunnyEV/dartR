#' Recalculate locus metrics when individuals or populations are deleted from a genlight \{adegenet\} object
#'
#' When individuals are deleted from a genlight object generated by DArT, the locus metrics no longer
#' apply. For example, the Call Rate may be different considering the subset of individuals, compared
#' with the full set. This script recalculates those affected locus metrics, namely, avgPIC, CallRate,
#' freqHets, freqHomRef, freqHomSnp, OneRatioRef, OneRatioSnp, PICRef and PICSnp. Metrics that remain
#' unaltered are RepAvg and TrimmedSeq as they are unaffected by the removal of individuals.
#' 
#' The script optionally removes resultant monomorphic loci or loci
#' with all values missing and deletes them (using gl.filter.monomorphs.r). 
#' 
#' The script returns a genlight object with the recalculated locus metadata.
#'
#' @param x -- name of the genlight object containing SNP genotypes [required]
#' @param verbose -- verbosity: 0, silent or fatal errors; 1, begin and end; 2, progress log ; 3, progress and results summary; 5, full report [default 2]
#' @return A genlight object with the recalculated locus metadata
#' @export
#' @author Arthur Georges (Post to \url{https://groups.google.com/d/forum/dartr})
#' @examples
#'   gl <- gl.recalc.metrics(testset.gl, verbose=2)
#' @seealso \code{\link{gl.filter.monomorphs}}

gl.recalc.metrics <- function(x, verbose=2){
  
# TIDY UP FILE SPECS

  funname <- match.call()[[1]]

# FLAG SCRIPT START

  if (verbose < 0 | verbose > 5){
    cat("  Warning: Parameter 'verbose' must be an integer between 0 [silent] and 5 [full report], set to 2\n")
    verbose <- 2
  }

  if (verbose > 0) {
    cat("Starting",funname,"\n")
  }

# STANDARD ERROR CHECKING
  
  if(class(x)!="genlight") {
    cat("  Fatal Error: genlight object required!\n"); stop("Execution terminated\n")
  }

  if (nLoc(x)!=nrow(x@other$loc.metrics)) { stop("The number of rows in the @other$loc.metrics table does not match the number of loci in your genlight object!! Most likely you subset your dataset using the '[ , ]' function of adegenet. This function does not subset the number of loci [you need to subset the loci metrics by 'hand' if you are using this approach].")  }
  
  # Set a population if none is specified (such as if the genlight object has been generated manually)
    if (is.null(pop(x)) | is.na(length(pop(x))) | length(pop(x)) <= 0) {
      if (verbose >= 2){ cat("  Population assignments not detected, individuals assigned to a single population labelled 'pop1'\n")}
      pop(x) <- factor(rep("pop1", nInd(x)))
    }

  # Check for monomorphic loci [done in utils.recalc.avgpic]
  #  tmp <- gl.filter.monomorphs(x, verbose=0)
  #  if ((nLoc(tmp) < nLoc(x)) & verbose >= 2) {cat("  Warning: genlight object contains monomorphic loci\n")}

# DO THE JOB

# Recalculate statistics
  x <- utils.recalc.avgpic(x,verbose=verbose)
  x <- utils.recalc.callrate(x,verbose=verbose)
  x <- utils.recalc.maf(x,verbose=verbose)
  ###################################################
  ####x <- utils.recalc.rdepth(x,verbose=verbose)
  ###################################################
  if (verbose >= 2) {
    cat("  Locus metrics recalculated\n")
  }
  
# FLAG SCRIPT END

  if (verbose > 0) {
    cat("Completed:",funname,"\n")
  }
  #add to history
  nh <- length(x@other$history)
  x@other$history[[nh + 1]] <- match.call()  
  return (x)

}  
