engigma_compact <- function (l) Filter(Negate(is.null), l)

#' Error handler function for enigma_* functions
#' @param x A response object from a call to \code{httr::GET}
#' @keywords internal
error_handler <- function(x){
  res_info <- content(x)$info
  if(x$status_code %in% c(400,500)){
    stop(sprintf("%s : %s", res_info$message, gsub('\"', "'", res_info$additional)), call. = FALSE)
  }
  stopifnot(x$headers$`content-type` == 'application/json; charset=utf-8')
  dat <- content(x, as = "text", encoding = 'utf-8')
  jsonlite::fromJSON(dat, FALSE)
}

check_dataset <- function(dataset){
  if(is.null(dataset)) stop("You must provide a dataset")
}

check_key <- function(x){
  if(is.null(x)) getOption("enigmaKey", stop("need an API key for the Enigma API")) else x
}

en_base <- function() 'https://api.enigma.io/v2'
