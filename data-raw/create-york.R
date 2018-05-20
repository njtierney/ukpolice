download.file(url = "https://opendata.arcgis.com/datasets/1dd964a0cae448c2b75097a8ff6a2227_15.csv",
destfile = "york.csv")

york <- readr::read_csv("york.csv")

names(york) <- c("long",
                 "lat",
                 "desig_id",
                 "bldg_name",
                 "grade",
                 "status_date",
                 "esri_oid")
