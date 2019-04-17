#' Find stop and search at street level
#'
#' Crimes at street-level; either within a 1 mile radius of a single point
#'     (`ukp_stop_search`), or within a custom area (`ukp_stop_search_poly`).
#'     The street-level crimes returned in the API are only an approximation of
#'     where the actual crimes occurred, they are not the exact locations. See
#'     the about page (<https://data.police.uk/about/#location-anonymisation>)
#'     for more information about location anonymisation. Note that crime
#'     levels may appear lower in Scotland, as only the British Transport
#'     Police provide this data.
#'
#' @param lat latitude of the requested crime area
#' @param lng, longitude of the requested crime area
#' @param poly_df dataframe containing the lat/lng pairs which define the
#'   boundary of the custom area. If a custom area contains more than 10,000
#'   crimes, the API will return a 503 status code. ukp_crime_poly converts the
#'   dataframe into lat/lng pairs, separated by colons:
#'   `lat`,`lng`:`lat`,`lng`:`lat`,`lng`. The first and last coordinates need
#'   not be the same — they will be joined by a straight line once the request
#'   is made.
#' @param date, Optional. (YYY-MM), limit results to a specific month. The
#'   latest month will be shown by default. e.g. date = "2013-01"
#' @param ... further arguments passed to or from other methods. For example,
#'   verbose option can be added with
#'   `ukp_api("call", config = httr::verbose())`. See more in `?httr::GET`
#'  documentation
#'   (<https://cran.r-project.org/web/packages/httr/>) and
#'   (<https://cran.r-project.org/web/packages/httr/vignettes/quickstart.html>).
#' @name ukp_stop_search
#'
#' @note The API will return a 400 status code in response to a GET request
#'   longer than 4094 characters. For submitting particularly complex poly
#'   parameters, consider using POST instead.
#'
#' @return a tibble with the columns:
#'   - type:	Whether this was a 'Person search', a 'Vehicle search', or a
#'     'Person and Vehicle search'
#'   - involved_person:	Whether a person was searched in this incident
#'     (derived from type; true if anything but 'Vehicle search')
#'   - datetime:	When the stop and search took place. Note that some forces
#'     only provide dates for their stop and searches, so you might see a
#'     disproportionate number of incidents occurring at midnight.
#'   - operation: (not always present in data)	Whether this stop and search
#'     was part of a policing operation
#'   - operation_name: (not always present in data) name of the operation this
#'     stop and search was part of
#'   - location:	Approximate location of the incident
#'   - latitude:	Latitude
#'   - longitude:	Longitude
#'   - street:	The approximate location of the incident
#'   - id:	Unique identifier for the location
#'   - name:	Human-readable summary of the location
#'   - gender:	Human-readable gender of the person stopped, if applicable
#'     and provided
#'   - age_range:	The age range of the person stopped at the time the stop
#'     occurred
#'   - self_defined_ethnicity:	The self-defined ethnicity of the person stopped
#'   - officer_defined_ethnicity:	The officer-defined ethnicity of the person
#'     stopped
#'   - legislation:	The power used to carry out the stop and search
#'   - object_of_search:	The reason the stop and search was carried out
#'   - outcome:	The outcome of the stop. false if nothing was found, an empty
#'     string if no outcome was provided.
#'   - outcome_linked_to_object_of_search:	Whether the outcome was related to
#'     the reason the stop and search was carried out, as a boolean value
#'     (or null if not provided)
#'   - removal_of_more_than_outer_clothing:	Whether the person searched had
#'     more than their outer clothing removed, as a boolean value (or null if
#'     not provided)
#' @note more documentation here:
#'   <https://data.police.uk/docs/method/stops-street/>
#'
#' @examples
#'
#' ukp_stop_search_data <- ukp_stop_search(lat = 52.629729,
#'                                         lng = -1.131592)
#'
#' head(ukp_stop_search_data)
#'
#' @export
ukp_stop_search <- function(lat,
                            lng,
                            date = NULL,
                            ...){

  # if date is used
  if (is.null(date) == FALSE) {

    api_string <- glue::glue("api/stops-street?lat={lat}&lng={lng}&date={date}")

    # else if no date is specified
  } else if (is.null(date) == TRUE) {

    api_string <- glue::glue("api/stops-street?lat={lat}&lng={lng}")

  }

  result <- ukp_api(api_string)
  extract_result <- purrr::map_dfr(.x = result$content,
                                   .f = ukp_crime_unlist)


  # rename the data
  extract_result <- dplyr::rename(
    extract_result,
    lat = location.latitude,
    long = location.longitude,
    street_id = location.street.id,
    street_name = location.street.name,
    outcome_object_id = outcome_object.id,
    outcome_object_name = outcome_object.name,
  )

  final_result <- dplyr::mutate(extract_result,
                                lat = as.numeric(lat),
                                long = as.numeric(long))

  final_result <- dplyr::select(final_result,
                                type,
                                involved_person,
                                datetime,
                                lat,
                                long,
                                street_id,
                                street_name,
                                dplyr::everything())

  return(final_result)

} # end function

#' @name ukp_stop_search
#' @examples
#'
#' # with 3 points
#' poly_df_3 = data.frame(lat = c(52.268, 52.794, 52.130),
#'                        long = c(0.543, 0.238, 0.478))
#'
#' ukp_data_poly_3 <- ukp_stop_search_poly(poly_df_3)
#' head(ukp_data_poly_3)
#'
#' # with 4 points
#' poly_df_4 = data.frame(lat = c(52.268, 52.794, 52.130, 52.000),
#'                        long = c(0.543,  0.238,  0.478,  0.400))
#' ukp_data_poly_4 <- ukp_stop_search_poly(poly_df = poly_df_4)
#'
#' head(ukp_data_poly_4)
#'
#' @export
ukp_stop_search_poly <- function(poly_df,
                                 date = NULL,
                                 ...){

  # poly must be a dataframe
  stopifnot(inherits(poly_df, "data.frame"))

  # "poly_df must contain columns named 'lat' and 'long'"
  stopifnot(c("lat", "long") %in% names(poly_df))

  poly_string <- ukp_poly_paste(poly_df,
                                "long",
                                "lat")

  # if date is used
  if (!is.null(date)) {
    api_string <- glue::glue("api/stops-street?poly={poly_string}&date={date}")
    # else if no date is specified
  } else if (is.null(date)) {
    api_string <- glue::glue("api/stops-street?poly={poly_string}")
  } # end ifelse

  result <- ukp_api(api_string)

  extract_result <- purrr::map_dfr(.x = result$content,
                                   .f = ukp_crime_unlist)

  # rename the data
  extract_result <- dplyr::rename(
    extract_result,
    lat = location.latitude,
    long = location.longitude,
    street_id = location.street.id,
    street_name = location.street.name,
    outcome_object_id = outcome_object.id,
    outcome_object_name = outcome_object.name,
  )

  final_result <- dplyr::mutate(extract_result,
                                lat = as.numeric(lat),
                                long = as.numeric(long))

  final_result <- dplyr::select(final_result,
                                datetime,
                                lat,
                                long,
                                street_id,
                                street_name,
                                dplyr::everything())

  return(final_result)

} # end function

#' ukp_crime_street_outcome
#' ukp_crime_location
#' ukp_crime_no_location
#' ukp_crime_categories

# Outcomes for a specific crime:
# https://data.police.uk/docs/method/outcomes-for-crime/
#' ukp_crime_outcome

# Stop and search related
# Stop and searches by area
# Stop and searches by location
# Stop and searches with no location
# Stop and searches by force
