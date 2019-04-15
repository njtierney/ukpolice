# Generate latitude / longitude for exploring the data
# install.packages("opencage")
library(opencage)

london_geocode <- opencage_forward(placename = "London, England")
lat_london <- london_geocode$results$geometry.lat[1]
lng_london <- london_geocode$results$geometry.lng[1]

cambridge_geocode <- opencage_forward(
  placename = "Cambridge University, England"
  )
lat_cambridge <- cambridge_geocode$results$geometry.lat[1]
lng_cambridge <- cambridge_geocode$results$geometry.lng[1]

oxford_geocode <- opencage_forward(
  placename = "Oxford University, England"
  )
lat_oxford <- oxford_geocode$results$geometry.lat[1]
lng_oxford <- oxford_geocode$results$geometry.lng[1]

abbyrd_geocode <- opencage_forward(
  placename = "Abby Road Recording Studio, England"
  )
lat_abby_rd <- abbyrd_geocode$results$geometry.lat[1]
lng_abby_rd <- abbyrd_geocode$results$geometry.lng[1]

liverpool_geocode <- opencage_forward(placename = "Liverpool City, England")
lat_liverpool <- liverpool_geocode$results$geometry.lat[1]
lng_liverpool <- liverpool_geocode$results$geometry.lng[1]

use_data(lat_abby_rd)
use_data(lat_cambridge)
use_data(lat_liverpool)
use_data(lat_london)
use_data(lat_oxford)

use_data(lng_abby_rd)
use_data(lng_cambridge)
use_data(lng_liverpool)
use_data(lng_london)
use_data(lng_oxford)
