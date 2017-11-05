library(dplyr)
library(rio)

states <- data_frame(state = state.name, code = state.abb)
dat <- rio::import("state_ESA_2017-09-01_app.xlsx")

dat <- left_join(dat, states, by = "state")
dat$rank <- rank(-dat$total, ties.method = "first")
saveRDS(dat, "states_es_laws.rds")


# data key
key <- readRDS("states_es_laws_key.rds")
vars <- names(key)
k <- as_data_frame(t(key))
k$variable <- vars
k <- select(k, variable, 1:6)
names(k) <- c(
  "variable",
  "0 points",
  "0.5 points",
  "1 point",
  "2 points",
  "2.5 points",
  "3 points"
)
k <- filter(k, variable != "Score")
k <- k[1:16, ]
saveRDS(k, "states_es_laws_key_tall.rds")
