#' @title Format a number to percentage with required decimal places
#' @description This function accepts up to two parameters and returns a string with a percentage sign attached.
#' @param x The number to be formatted,
#' @param d The number of decimal places that should be retained after formatting. If parameter d is not provided, then the default is zero.
#'
#' @return A string that is \code{x} with percentage sign, %.
#'
#' @examples \dontrun{
#' addPercent(0.65423, 1)
#' addPercent(0.65423)
#' sapply(c(123.4546, .876589, 0.45678),addPercent, d=2)
#'}
#' @export
addPercent <- function(x, d){
  percent <- round(x * 100, digits = d)
  result <- paste(percent, "%", sep="")
  return(result)
}
