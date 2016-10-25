
ukpolice is an R package that facilitates retrieving data from the [UK police database.](https://data.police.uk/)

This package is under construction.

<!-- README.md is generated from README.Rmd. Please edit that file -->
Currently the only function is `get_neighbourhoods`, which retrieves a list of neighbourhoods for a force, <https://data.police.uk/docs/method/neighbourhoods/>

This returns a tibble with columns id and name.

``` r

library(ukpolice)
get_neighbourhoods("leicestershire")
#> No encoding supplied: defaulting to UTF-8.
#> # A tibble: 67 × 2
#>       id                           name
#>    <chr>                          <chr>
#> 1   NC04                    City Centre
#> 2   NC66               Cultural Quarter
#> 3   NC67                      Riverside
#> 4   NC68                 Clarendon Park
#> 5   NE09                 Belgrave South
#> 6   NE10                 Belgrave North
#> 7   NE11                    Rushey Mead
#> 8   NE12                    Humberstone
#> 9   NE13 Northfields, Tailby and Morton
#> 10  NE14                     Thurncourt
#> # ... with 57 more rows
```

id is a Police force specific team identifier, note that this identifier is not unique and may also be used by a different force. Name is the name for the neighbourhood

Contributor Code of Conduct
===========================

As contributors and maintainers of this project, we pledge to respect all people who contribute through reporting issues, posting feature requests, updating documentation, submitting pull requests or patches, and other activities.

We are committed to making participation in this project a harassment-free experience for everyone, regardless of level of experience, gender, gender identity and expression, sexual orientation, disability, personal appearance, body size, race, ethnicity, age, or religion.

Examples of unacceptable behavior by participants include the use of sexual language or imagery, derogatory comments or personal attacks, trolling, public or private harassment, insults, or other unprofessional conduct.

Project maintainers have the right and responsibility to remove, edit, or reject comments, commits, code, wiki edits, issues, and other contributions that are not aligned to this Code of Conduct. Project maintainers who do not follow the Code of Conduct may be removed from the project team.

Instances of abusive, harassing, or otherwise unacceptable behavior may be reported by opening an issue or contacting one or more of the project maintainers.

This Code of Conduct is adapted from the Contributor Covenant (<http:contributor-covenant.org>), version 1.0.0, available at <http://contributor-covenant.org/version/1/0/0/>
