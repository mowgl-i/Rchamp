#Creates the query list appropriately.
#' @importFrom stats setNames
query_list <- function(...){
  a <- list(...)
  as.list(
    setNames(
      unlist(a), rep(names(a), sapply(a, length))))
}

