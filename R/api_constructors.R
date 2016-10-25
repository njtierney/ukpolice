#' ukpolice_api
#'
#' @param path character
#'
#' @return a ukpolice_api object
#' @importFrom utils str
#' @export

ukpolice_api <- function(path) {
  url <- httr::modify_url("https://data.police.uk/", path = path)

  # specify the agent
  ua <- httr::user_agent("http://github.com/njtierney/ukpolice")

  resp <- httr::GET(url, ua)
  if (httr::http_type(resp) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }

  parsed <- jsonlite::fromJSON(httr::content(resp, "text"), simplifyVector = FALSE)

  if (httr::http_error(resp)) {
    stop(
      sprintf(
        "UK Police API request failed [%s]\n%s\n<%s>",
        httr::status_code(resp),
        parsed$message,
        parsed$documentation_url
      ),
      call. = FALSE
    )
  }

  structure(
    list(
      content = parsed,
      path = path,
      response = resp
    ),
    class = "ukpolice_api"
  )

}

#' print method for ukpolice_api
#'
#' @param x ukpolice_api object
#' @param ... further arguments passed to or from other methods.
#'
#' @return a special print method lifted from https://cran.r-project.org/web/packages/httr/vignettes/api-packages.html
#' @export
#'
print.ukpolice_api <- function(x, ...) {
  cat("<ukpolice ", x$path, ">\n", sep = "")
  str(x$content)
  invisible(x)
}
