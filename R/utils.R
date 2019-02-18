#' ukpolice API call
#'
#' `ukp_api` is the basic building block for making requests out to the uk
#'   police database.
#'
#' @param path character
#' @param ... further arguments passed to or from other methods. For
#'     example, verbose option can be added with
#'     `ukp_api("call", config = httr::verbose())`. See more in `?httr::GET`
#'     documentation (https://cran.r-project.org/web/packages/httr/) and
#'     (https://cran.r-project.org/web/packages/httr/vignettes/quickstart.html).
#'
#' @return a `ukpolice_api`` object
#'
#' @note Regaring authentication, the Police API no longer requires
#'     authentication. If a request succeeds, the API will return a 200 status
#'     code. If a request fails, the API will return a non-200 status code.
#'
#' @note Regarding API call limits, the Police API call limit operates using
#'     a 'leaky bucket' algorithm as a controller. This allows for infrequent
#'     bursts of calls, and allows you to continue to make an unlimited amount
#'     of calls over time. The current rate limit is 15 requests per second
#'     with a burst of 30. So, on average you must make fewer than 15 requests
#'     each second, but you can make up to 30 in a single second. You can learn
#'     more about the leaky bucket algorithm,
#'     https://en.wikipedia.org/wiki/Leaky_bucket.
#'
#' @note Regarding HTTP headers and response codes, If you exceed the limit
#'   stated above, the API will return a HTTP 429 (Too Many Requests)
#'   response code.
#'
#' @importFrom utils str
#' @export

ukp_api <- function(path, ...) {
  url <- httr::modify_url("https://data.police.uk/", path = path)

  # specify the agent
  ua <- httr::user_agent("http://github.com/njtierney/ukpolice")

  resp <- httr::GET(url, ua, ...)
  if (httr::http_type(resp) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }

  parsed <- jsonlite::fromJSON(httr::content(resp, "text"),
                               simplifyVector = FALSE)

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
    class = "ukp_api"
  )

}

#' Print method for ukpolice_api
#'
#' @param x object of class "ukp_api"
#' @param ... further arguments passed to or from other methods. For
#'     example, verbose option can be added with
#'     `ukp_api("call", config = httr::verbose())`. See more in `?httr::GET`
#'     documentation (https://cran.r-project.org/web/packages/httr/) and
#'     (https://cran.r-project.org/web/packages/httr/vignettes/quickstart.html).

#'
#' @return a special print method lifted from
#'   https://cran.r-project.org/web/packages/httr/vignettes/api-packages.html
#' @export
#'
print.ukp_api <- function(x, ...) {
  cat("<ukpolice ", x$path, ">\n", sep = "")
  str(x$content)
  invisible(x)
}

#' Find the date of the latest update from the UK Police databse
#'
#' Crime data in the API is updated once a month. Find out when it was last
#'   updated using `ukp_last_update`.
#'
#' @param ... further arguments passed to or from other methods. For example,
#'   verbose option can be added with
#'   `ukp_api("call", config = httr::verbose())`.
#'   See more in `?httr::GET` documentation
#'   (https://cran.r-project.org/web/packages/httr/) and
#'   (https://cran.r-project.org/web/packages/httr/vignettes/quickstart.html).
#' @return date	Month of latest crime data in ISO format. The day is irrelevant
#'   and is only there to keep a standard formatted date. Read more at
#'   https://data.police.uk/docs/method/crime-last-updated/
#'
#' @export
ukp_last_update <- function(...){
  result <- ukp_api("api/crimes-street-dates")
  # get the most recent update from the crimes-street-dates
  result$content[[1]]$date
}
#'
# #' ukp_available_data
# #'
# #' Returns a list of available data sets
# #' @param data type of data to be searched. For example: "crimes-street-dates"
# #' @param ... further arguments passed to or from other methods. For example, verbose option can be added with ukp_api("call", config = httr::verbose()). See more in ?httr::GET documentation (https://cran.r-project.org/web/packages/httr/) and (https://cran.r-project.org/web/packages/httr/vignettes/quickstart.html).

# #'
# #' @return tibble with two columns, date, and stop-and-search. Date contains the Year and month of all available street level crime data in ISO format. stop-and-search contains a list of force IDs for forces that have provided stop and search data for this month. Read more here: https://data.police.uk/docs/method/crimes-street-dates/
# #'
# #' @export
# ukp_available_data <- function(data, ...){
#   # https://data.police.uk/api/crimes-street-dates
#   data = "crimes-street-dates"
#   # data = "forces"
#   result <- ukp_api(sprintf("api/%s",data))
#   class(result$content[[1]])
#   length(result$content[[1]])
#   lengths(result$content)
#   result$content[[1]][2]
#   dplyr::bind_rows(result$content)
#
# }
