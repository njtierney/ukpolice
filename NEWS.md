# ukpolice 0.0.1.9100 (2019-04-15)

## Minor Improvements

* Added `lat_` and `lng_` example data so people can explore crime in a few places like "London", "Cambridge University", "Oxford University", "Abby Road Recording Studio", and "Liverpool city".

# ukpolice 0.0.1.9000 (2018-05-20)

## Minor Improvements

* Minor clean ups from the past 18 months:
  * removed maxcovr as suggestions
  * used markdown in roxygen
  * tweak README and README figures
  * Added a vignette

## New Features

* Added the "york" dataset, which contains information on listed buildings in the city of York, UK. This is used to demonstrate defining polygon around a region and finding crime within in.

# ukpolice 0.0.0.9200 (2016-11-15)

## MINOR IMPROVEMENTS

* `ukp_crime_poly()` now takes a data.frame of long/lat points instead of an long character vector. This is due to the utility function `ukp_poly_paste`.
* added `ukp_geo_chull` which takes a data.frame and some lon/lat names and provides the dataframe which contains the convex hull of points. This can then be fed into `ukp_crime_poly()`.

# ukpolice 0.0.0.9100 (2016-11-14)

## NEW FEATURES

* Add `ukp_crime_poly()`, which is like `ukp_crime()`, but takes multiple pairs of long/lat to extract crime that falls within a polygon, instead of within a one mile radius of a particular point
* Added unexported function `ukp_crime_unlist` which flattens the crime data.

# ukpolice 0.0.0.9002 (2016-11-05)

## NEW FEATURES

* Created `ukp_crime()`, which accesses the crimes that occur within one mile of a given latitude and longitude, and from a specific month
* Created function `ukp_last_update()`, to search for the last update in the crime data.
* Added pkgdown website for the package documentation

# ukpolice 0.0.0.9001 (2016-10-26)

## MINOR IMPROVEMENTS
* Changed all functions to have prefix `ukp_`, so `get_neighbourhoods` changed to `ukp_neighbourhood()`, and `ukpolice_api()` changed to `ukp_api()`, as suggested by @sckott in [issue #6](https://github.com/njtierney/ukpolice/issues/6).
* Added function `ukp_neighbourhood_force()`, to find associated neighbourhood forcename and neighbourhood ID.
* Added `...` option in `ukp_api()`, to facilitate debugging, as suggested by @sckott in [issue #7](https://github.com/njtierney/ukpolice/issues/7)

# ukpolice 0.0.0.9000 (2016-10-25)

## NEW FEATURES
* Added a `NEWS.md` file to track changes to the package.
* Added the `get_neighbourhoods` function.

<!--NEW FEATURES, MINOR IMPROVEMENTS, BUG FIXES, DEPRECATED AND DEFUNCT -- >
