#' List Police Forces in the UK
#'
#' This is an empty function called as `ukp_list_forces()`. This lists all the
#'   police forces available via the UK police API. The unique force identifiers
#'   can be used in requests for force-specific data. Such as [ukp_force()] and
#'   [ukp_force_people()].
#'
#' @return table with columns `id` and `name`.`id` is a Unique force identifier,
#'   `name` is the force name.
#'
#' @export
#' @examples
#' ukp_list_forces()
ukp_list_forces <- function(){
    result <- ukp_api("api/forces")

    extract_result <- purrr::map_dfr(.x = result$content,
                                     .f = ukp_crime_unlist)

    extract_result

}

#' List Information about a specific force in the UK
#'
#' List specific information for a given police force in the UK.
#'
#' https://data.police.uk/docs/method/force/
#' returns this information
    # Tag	Description
    # description	Description
    # url	Force website URL
    # engagement-methods	Ways to keep informed
    # url	Method website URL
    # description	Method description
    # title	Method title
    # telephone	Force telephone number
    # id	Unique force identifier
    # name	Force name
#'
ukp_forces <- function(force){
    result <- ukp_api(glue::glue("api/forces/{force}"))

    extract_result <- purrr::map_dfr(.x = result$content[[3]],
                                     .f = ukp_crime_unlist)

    return(extract_result)

}
#' Force senior officers
#'
#' ukp_forces_people
#'
#' returns the following information:
    # Tag	Description
    # bio	Senior officer biography (if available)
    # contact_details	Contact details for the senior officer
    # email	Email address
    # telephone	Telephone number
    # mobile	Mobile number
    # fax	Fax number
    # web	Website address
    # address	Street address
    # facebook	Facebook profile URL
    # twitter	Twitter profile URL
    # youtube	YouTube profile URL
    # myspace	Myspace profile URL
    # bebo	Bebo profile URL
    # flickr	Flickr profile URL
    # google-plus	Google+ profile URL
    # forum	Forum URL
    # e-messaging	E-messaging URL
    # blog	Blog URL
    # rss	RSS URL
    # name	Name of the person
    # rank	Force rank
ukp_forces_people <- function(force){
    result <- ukp_api(glue::glue("api/forces/{force}/people"))

    browser()
    extract_result <- purrr::map_dfr(.x = result$content,
                                     .f = ukp_crime_unlist)

    return(extract_result)
}
