# Utility functions used by the crime functions --------------------------------

#' ukp_crime_unlist
#'
#' Utility function to clean and unlist the data extracted from the crime data
#'
#' @param result_content a result from the ukp_api
#'
#' @return  data.frame

ukp_crime_unlist <- function(result_content){

  result_unlist <- unlist(result_content)

  result_df <- as.data.frame(result_unlist, stringsAsFactors = FALSE)

  result_df <- dplyr::mutate(result_df, variables = rownames(result_df))

  result_df <- dplyr::select(result_df,
                             variables,
                             result_unlist)

  result_df <- tidyr::spread(result_df,
                             key = "variables",
                             value = "result_unlist")

  result_df <- tibble::as_tibble(result_df)

  return(result_df)

} # end

#' ukp_poly_paste
#'
#' Takes a dataframe oif longitude and latitude and pastes them into the correct
#'     format required for the ukpolice API
#'
#' @param data a dataframe
#' @param long character
#' @param lat character
#'
#' @return character vector: "lat_1,long_1:lat_2,long_2:...,lat_n,long_n"
#'
#' @examples
#'
#' \dontrun{
#'
#' library(maxcovr)
#'
#' ukp_poly_paste_2(york, "long", "lat")
#'
#' }
#'
ukp_poly_paste <- function(data,
                           long,
                           lat){
  #
  # create rowise paste of long and lat, sperated by a comma
  poly_paste <- dplyr::mutate(data,
                              chull_paste = paste(lat,
                                                  long,
                                                  sep = ","))

  # paste together each row, separate by a colon
  return(paste(poly_paste$chull_paste, collapse = ":"))

}
#' ukp_geo_chull
#'
#' compute the convex hull of some lon/lat points
#'
#' @param data a dataframe
#' @param long longitude
#' @param lat latitude
#'
#' @return a
#'
#'
#' @examples
#'
#' \dontrun{
#'
#' library(maxcovr)
#'
#' # identify the polygon you want to draw
#' poly_string <- ukp_geo_chull(data = york,
#'                              long = long,
#'                              lat = lat)
#'
#' ukp_crime_poly()
#'
#'
#' }
#'
#' @export
ukp_geo_chull <- function(data,
                          long,
                          lat){

  long_name <- deparse(substitute(long))
  lat_name <- deparse(substitute(lat))

  data_chull <- data[grDevices::chull(data[[long_name]], data[[lat_name]]), ]

  # unsure if I really need to subset the data...
  # data_chull <- dplyr::select_(data_chull,
  #                              long_name,
  #                              lat_name)

  return(data_chull)
}
  # ukp_poly_paste(data_chull, data_chull[[long]], data_chull[[lat]])

  # potential arguments for the chull widening arguments -------------------
    # hull is the subset of data that contains the convex hull
    # centroid is the centre point, created from
  # library(maxcovr)
  # library(ukpolice)
  # library(rgeos)
  # library(sp)
  # library(tidyverse)
  # identify the polygon you want to draw
  # poly_string <- ukp_geo_chull(data = york,
  #                              long = long,
  #                              lat = lat)

  # requires a matrix....
  # need tor read up on what these steps do, and what I could extend.
  # centroid <- sp::Polygon(poly_string) %>%
  #   sp::SpatialPoints() %>%
  #   rgeos::gCentroid() %>%
  #   data.frame()


  # z is the size of the hull widening.
  # z <- 1

#   newhull <- cbind(hull, centroid) %>%
#     mutate(dx = `1` - x,
#            dy = `2` - y) %>%
#     # euclidean distance
#     mutate(dr = sqrt(dx^2 + dy^2),
#            dx = dx/dr,
#            dy = dy/dr) %>%
#     mutate(newx = `1` + z*dx,
#            newy = `2` + z*dy)
#
#
# }

# library(tidyverse)
# head_york <- head(york)
#
# poly_paste(head_york,
#            long = head_york$long,
#            lat = head_york$lat)
#
# geo_chull_paste(york,
#                 long = york$long,
#                 lat = york$lat)
# library(leaflet)

