#' @title Round and keep the significant digits to the right of a decimal
#'
#' @description This function allows the user to specify a number of significant digits, keeps significant zeroes
#' and the digits to the left of the decimal point.
#'
#' @param x The number to be formatted,
#' @param d The number of significant figures that should be retained after formatting. If parameter d is not provided, then the function will fail.
#'
#' @return A string that is \code{x}.
#'
#' @details This function relies on the stringr library. More specifically, it utilizes the str_pad function within stringr to pad with zeros when there are decimals present after rounding.
#' The function will also use grepl to test whether there are decimals within the formatted number and if not will return all the same digits but as a string.
#'
#' @seealso \code{\link{grepl}}
#' @seealso \code{\link{prettyNum}}
#'
#' @examples \dontrun{
#' signifDigit(5423.63875,2)
#' sapply(c(123.4546, 87.6589, 9.5678),signifDigit,d=3)
#' }
#' @export

signifDigit <- function(x,d){
  y <- format(x,digits=d)
  if (!grepl("[.]",y)) return(y)
  return(stringr::str_pad(y,d+1,"right","0"))
}
