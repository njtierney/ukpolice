#' get_neighbourhoods
#'
#' This call retuns the list of neighbourhoods for a force, https://data.police.uk/docs/method/neighbourhoods/
#'
#' @param neighbourhood a text string of a neighbourhood in the UK
#'
#' @return tibble with columns id and name. id is a Police force specific team identifier, note that this identifier is not unique and may also be used by a different force. Name is the name for the neighbourhood
#' @export
#'
#' @examples
#'
#' \dontrun{
#' library(ukpolice)
#' get_neighbourhoods("leicestershire")
#'
# # A tibble: 67 × 2
#      id                            name
#    <chr>                          <chr>
# 1   NC04                    City Centre
# 2   NC66               Cultural Quarter
# 3   NC67                      Riverside
# 4   NC68                 Clarendon Park
# 5   NE09                 Belgrave South
# # ...
#
#' }
#'
get_neighbourhoods <- function(neighbourhood){

  result <- ukpolice_api(sprintf("api/%s/neighbourhoods",neighbourhood))

  dplyr::bind_rows(result$content)

}


