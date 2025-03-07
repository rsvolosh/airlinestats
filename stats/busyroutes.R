# Here, we want to look at what airports are most dominated by which airlines,
# using the same data. For simplicity, we only look at departing flights. Since
# most departing flights have a corresponding return flight, this should be fairly
# accurate.

devtools::load_all()

DATA_PATH = Sys.getenv("DATA_PATH")

data = load_data(file.path(DATA_PATH, "air_sample.csv"),
                 file.path(DATA_PATH, "L_CITY_MARKET_ID.csv"),
                 file.path(DATA_PATH, "L_CARRIERS.csv"))

busiest_routes(data, Origin, Dest)

busiest_routes(data, OriginCity, DestCity)
