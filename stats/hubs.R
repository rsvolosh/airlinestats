# Here, we want to look at what airports are most dominated by which airlines,
# using the same data. For simplicity, we only look at departing flights. Since
# most departing flights have a corresponding return flight, this should be fairly
# accurate.

devtools::load_all()

DATA_PATH = Sys.getenv("DATA_PATH")

data = load_data(file.path(DATA_PATH, "air_sample.csv"),
                 file.path(DATA_PATH, "L_CITY_MARKET_ID.csv"),
                 file.path(DATA_PATH, "L_CARRIERS.csv"))

# operating carrier market shares by o.city
op.car.mkt_shares <- market_shares(data, OperatingCarrierName, OriginCity)
# ticketing carrier market shares by o.city
tk.car.mkt_shares <- market_shares(data, TicketingCarrierName, OriginCity)

# operating carrier market shares by o.airport
op.car.airport.mkt_shares <- market_shares(data, OperatingCarrierName, Origin)
# ticketing carrier market shares by o.airport
tk.car.airport.mkt_shares <- market_shares(data, TicketingCarrierName, Origin)
