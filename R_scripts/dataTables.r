# Tutorial link: https://cran.r-project.org/web/packages/data.table/vignettes/datatable-intro.html

if(!require(data.table)) {
  install.packages("data.table", repos="http://cran.rstudio.com/"); suppressPackageStartupMessages(require(data.table))}

# Data
if(!require(nycflights13)) {
  install.packages("nycflights13", repos="http://cran.rstudio.com/"); suppressPackageStartupMessages(require(nycflights13))}

flights <- nycflights13::flights
flights <- as.data.table(flights)

jfk_origin_flights <- flights[origin == "JFK" & month == 6]

arr_delays <- flights[1,]

# How can we get the total number of trips for each origin, dest pair for carrier code “AA”?
ans1 <- flights[carrier == "AA", .(.N), list(origin, dest)]

# How can we get the average arrival and departure delay for each orig,dest pair for each month for carrier code “AA”?
ans2 <- flights[carrier == "AA", mean(dep_delay), by = .(origin, dest, month)]

# What if you were adding another calculated column, say mean(arr_delay)
ans3 <- flights[carrier == "AA", .(mean(dep_delay), mean(arr_delay)), by = .(origin, dest, month)]

# If you want to sort the results, use keyby instead of by
ans4 <- flights[carrier == "AA", .(av_dep_lay = mean(dep_delay), av_arr_delay = mean(arr_delay)), keyby = .(origin, dest, month)]

# Find mean of multiple columns together - arr_delay and dep_delay in this case
ans5 <- flights[carrier == "AA", lapply(.SD, mean()), by = .(origin, dest, month), .SDcol = c("arr_delay", "dep_delay")]

# How can we return the first two rows for each month?
ans6 <- flights[, head(.SD, 2), by = month][order(as.numeric(month))]

# Adding a new column
ans7 <- flights[, `:=`(total_delay = arr_delay + dep_delay)]

# Replace missing data with mean of existing values
meanTotalDelay = mean(ans7$total_delay, na.rm = TRUE)
ans8 <- ans7[is.na(total_delay), total_delay := meanTotalDelay]

# Count of rows where total_delay == meanTotalDelay
ans7[is.na(total_delay), .N]
ans8[total_delay == meanTotalDelay, .N]


