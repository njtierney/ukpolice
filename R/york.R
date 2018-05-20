# York Listed Buildings.
#'
#' Listed buildings provided by the City of York Council, made available [here](https://data.gov.uk/dataset/9417652f-3901-4a16-8368-222deefb36cd/listed-buildings). This data contains public sector information licensed under the Open Government Licence v3.0: <https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/>.
#'
#' @format A data frame with seven variables: `long`, `lat`, `desig_id`,
#'  `bldg_name`, `grade`, `status_date`, and `esri_oid`.
#'
#' \describe{
#' \item{`long`}{longitude of the building}
#' \item{`lat`}{latitude of the building}
#' \item{`desig_id`}{ID related to a feature that is not yet known to me}
#' \item{`bldg_name`}{name of the building}
#' \item{`grade`}{one of the three (I, II, III) cateogories of listed buildings}
#' \item{`status_date`}{date the status was made}
#' \item{`esri_oid`}{ID related to a feature that is not yet known to me}
#' }
#'
#' For further details, see <https://www.york.gov.uk/info/20215/conservation_and_listed_buildings/1346/listed_buildings> and <https://data.gov.uk/dataset/9417652f-3901-4a16-8368-222deefb36cd/listed-buildings>
#'
"york"
