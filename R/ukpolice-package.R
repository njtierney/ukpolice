#' ukpolice
#'
#' A package to retriece data from the UK police data repository: ukpolice is
#'     an R package that facilitates retrieving data from the
#'     [UK police database.](https://data.police.uk/). The data provided by
#'     the API contains public sector information licensed under the
#'     [Open Government Licence v3.0.](http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/).
#'
#' @name ukpolice

if(getRversion() >= "2.15.1")

utils::globalVariables(c("category",
                         "context",
                         "id",
                         "lat",
                         "location.latitude",
                         "location.longitude",
                         "location.street.id",
                         "location.street.name",
                         "location_subtype",
                         "location_type",
                         "long",
                         "month",
                         "outcome_status",
                         "outcome_status.category",
                         "outcome_status.date",
                         "persistent_id",
                         "street_id",
                         "street_name",
                         "variables"))
