library(tidyverse)
print("start")

BQ1 <- read_csv(
  "data/QuebradaCuenca1-Bisley.csv",
  na = c("", "NA", "ND"))
BQ2 <- read_csv(
  "data/QuebradaCuenca2-Bisley.csv",
  na = c("", "NA", "ND"))
BQ3 <- read_csv(
  "data/QuebradaCuenca3-Bisley.csv",
  na = c("", "NA", "ND"))
PRM <- read_csv(
  "data/RioMameyesPuenteRoto.csv",
  na = c("", "NA", "ND"))
print("end")

class(BQ1$Sample_Date)
glimpse(BQ1)

ggplot(
  data = BQ1,
  mapping = aes(
    x = Sample_Date,
    y = `NO3-N`
  )
) +
  geom_point() +
  geom_line()