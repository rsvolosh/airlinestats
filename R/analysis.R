cleaning_func = function(dataframe, which = dataframe1) {
  # taking out NAs
  which(!complete.cases(dataframe))
  na_dataframe = which(!complete.cases(dataframe))
  dataframe1 = dataframe[-na_dataframe,]
  # taking out negative numbers
  dataframe2 = Filter(is.numeric, dataframe1)
  dataframe3 = dataframe %>% rowwise() %>% mutate(has_negatives=rowSums(across(everything(), ~(.<0))))
  if (which == dataframe1) {return(dataframe1)} else
    if (which == dataframe3) {return(dataframe3)} else {return(dataframe)}
}

#' @export
busiest_routes = function(dataframe, origcol, destcol) {

  stopifnot(all(dataframe$Passengers >= 1))
  stopifnot(all(!is.na(dataframe$Passengers)))

  # Now, we can see what the most popular air route is, by summing up the number of
  # passengers carried.
  pairs = group_by(dataframe, {{origcol}}, {{destcol}}) %>%
    summarise(Passengers=sum(Passengers), distance_km=first(Distance) * km_per_mile)
  arrange(pairs, -Passengers)

  # we see that LAX-JFK (Los Angeles to New York Kennedy) is represented separately
  # from JFK-LAX. We'd like to combine these two. Create airport1 and airport2 fields
  # with the first and second airport in alphabetical order.
  pairs = mutate(
    pairs, location1 = if_else({{origcol}} < {{destcol}}, {{origcol}}, {{destcol}}),
    location2 = if_else({{origcol}} < {{destcol}}, {{destcol}}, {{origcol}})
  )

  pairs <- pairs %>% group_by(location1, location2) %>%
    summarise(Passengers=sum(Passengers), distance_km=first(distance_km))

  return(arrange(pairs, -Passengers))
}

#' @export
market_shares = function(dataframe, carrier, origin) {
  # Now, we can compute the market shares

  mkt_shares = group_by(dataframe, {{carrier}}, {{origin}}) %>%
    group_by({{origin}}) %>%
    mutate(market_share=Passengers/sum(Passengers), total_passengers=sum(Passengers)) %>%
    ungroup()

  return(arrange(mkt_shares, -market_share))
}

