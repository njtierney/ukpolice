# Street level crimes ----------------------------------------------------------
#' ukp_crime
#'
#' Crimes at street-level; either within a 1 mile radius of a single point, or within a custom area. The street-level crimes returned in the API are only an approximation of where the actual crimes occurred, they are not the exact locations. See the about page (https://data.police.uk/about/#location-anonymisation) for more information about location anonymisation. Note that crime levels may appear lower in Scotland, as only the British Transport Police provide this data.
#'
#' @param lat latitude of the requested crime area
#' @param lng, longitude of the requested crime area
#' @param date, Optional. (YYY-MM), limit results to a specific month. The latest month will be shown by default. e.g. date = "2013-01"
#' @param ... further arguments passed to or from other methods. For example, verbose option can be added with ukp_api("call", config = httr::verbose()). See more in ?httr::GET documentation (https://cran.r-project.org/web/packages/httr/) and (https://cran.r-project.org/web/packages/httr/vignettes/quickstart.html).
#'
#' @note The API will return a 400 status code in response to a GET request longer than 4094 characters. For submitting particularly complex poly parameters, consider using POST instead.
#'
#' @return a tibble with the columns:
#' \itemize{
#'   \item category: Category of the crime (https://data.police.uk/docs/method/crime-street/)
#'   \item persistent_id: 64-character unique identifier for that crime. (This is different to the existing 'id' attribute, which is not guaranteed to always stay the same for each crime.)
#'   \item date: Date of the crime YYYY-MM
#'   \item latitude: Latitude
#'   \item longitude: Longitude
#'   \item street_id: Unique identifier for the street
#'   \item street_name: Name of the location. This is only an approximation of where the crime happened
#'   \item context: Extra information about the crime (if applicable)
#'   \item id: ID of the crime. This ID only relates to the API, it is NOT a police identifier
#'   \item location_type: The type of the location. Either Force or BTP: Force indicates a normal police force location; BTP indicates a British Transport Police location. BTP locations fall within normal police force boundaries.
#'   \item location_subtype: For BTP locations, the type of location at which this crime was recorded.
#'   \item outcome_status: The category and date of the latest recorded outcome for the crime
#' }
#'
#' @note more documentation here: https://data.police.uk/docs/method/crime-street/
#'
#' @examples
#'
#' ukp_crime_data <- ukp_crime(lat = 52.629729, lng = -1.131592)
#'
#' head(ukp_crime_data)
#'
#' @export
#'
ukp_crime <- function(lat,
                      lng,
                      date = NULL,
                      ...){

  # transforms this particular JSON list structure into a tibble
  unlist_crime_df <- function(result_content){

    # result_content <- result$content[[1]]
    result_unlist <- unlist(result_content)
    result_df <- as.data.frame(result_unlist, stringsAsFactors = FALSE)
    result_df <- dplyr::mutate(result_df,
                               variables = rownames(result_df))
    result_df <- dplyr::select(result_df,
                               variables,
                               result_unlist)
    result_df <- tidyr::spread(result_df,
                               key = "variables",
                               value = "result_unlist")
    result_df <- tibble::as_tibble(result_df)

    return(result_df)

  }

  # if date is used
  if(is.null(date) == FALSE){

    result <- ukp_api(
      sprintf("api/crimes-street/all-crime?lat=%s&lng=%s&date=%s",
              lat,
              lng,
              date)
    )

  # else if no date is specified
  } else if(is.null(date) == TRUE){

    result <- ukp_api(
      sprintf("api/crimes-street/all-crime?lat=%s&lng=%s",
              lat,
              lng)
    )

  }

  extract_result <- purrr::map_df(.x = result$content,
                                  .f = unlist_crime_df)

  # rename the data
  extract_result <- dplyr::rename(extract_result,
                latitude = location.latitude,
                longitude = location.longitude,
                street_id = location.street.id,
                street_name = location.street.name,
                date = month,
                outcome_status = outcome_status.category,
                outcome_date = outcome_status.date)


  final_result <- dplyr::mutate(extract_result,
                                latitude = as.numeric(latitude),
                                longitude = as.numeric(longitude))

  final_result <- dplyr::select(final_result,
                                category,
                                persistent_id,
                                date,
                                latitude,
                                longitude,
                                street_id,
                                street_name,
                                context,
                                id,
                                location_type,
                                location_subtype,
                                outcome_status,
                                category)

  return(final_result)

}

# ukp_crime_street_poly
#
# Extract the crime areas within a polygon
#
# @param poly The lat/lng pairs which define the boundary of the custom area. If a custom area contains more than 10,000 crimes, the API will return a 503 status code. The poly parameter is formatted in lat/lng pairs, separated by colons: [lat],[lng]:[lat],[lng]:[lat],[lng]. The first and last coordinates need not be the same — they will be joined by a straight line once the request is made.
# @param date, Optional. (YYY-MM), limit results to a specific month. The latest month will be shown by default. e.g. date = "2013-01"
# #' @param ... further arguments passed to or from other methods. For example, verbose option can be added with ukp_api("call", config = httr::verbose()). See more in ?httr::GET documentation (https://cran.r-project.org/web/packages/httr/) and (https://cran.r-project.org/web/packages/httr/vignettes/quickstart.html).

#
# @note further documentation here: https://data.police.uk/docs/method/crime-street/
##
## @export
##
# ukp_crime_street_poly(poly,
#                       date = NULL,
#                       ...){
#
#   # transforms this particular JSON list structure into a tibble
#   unlist_crime_df <- function(result_content){
#
#     result_unlist <- unlist(result_content)
#
#     result_df <- as.data.frame(result_unlist) %>%
#       dplyr::mutate(variables = rownames(.)) %>%
#       dplyr::select(variables,
#                     result_unlist) %>%
#       tidyr::spread(key = "variables",
#                     value = "result_unlist") %>%
#       tibble::as_tibble()
#
#     result_df
#
#   }
#
#   poly = c("52.268,0.543:52.794,0.238:52.130,0.478")
#
#   # if date is used
#   if(is.null(date) == FALSE){
#
#     result <- ukp_api(
#       sprintf("api/crimes-street/all-crime?all-crime?poly=%s&date%s",
#               poly,
#               date)
#     )
#
#     # else if no date is specified
#   } else if(is.null(date) == TRUE){
#
#     result <- ukp_api(
#       sprintf("api/crimes-street/all-crime?all-crime?poly=%s",
#               poly)
#     )
#
#   }
#
#   extract_result <- purrr::map_df(.x = result$content,
#                                   .f = unlist_crime_df)
#
#   final_result <-
#     dplyr::rename(extract_result,
#                   latitude = location.latitude,
#                   longitude = location.longitude,
#                   street_id = location.street.id,
#                   street_name = location.street.name,
#                   date = month,
#                   outcome_category = outcome_status.category,
#                   outcome_date = outcome_status.date)
#
#   return(final_result)
#
# }

#' ukp_crime_street_outcome
#' ukp_crime_location
#' ukp_crime_no_location
#' ukp_crime_categories

# Outcomes for a specific crime:
# https://data.police.uk/docs/method/outcomes-for-crime/
#' ukp_crime_outcome
