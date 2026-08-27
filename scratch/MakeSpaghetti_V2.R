library(tidyverse)
print("start")
source("R/moving-average.R")

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
colnames(BQ1)

BQ1_Avg <- moving_average(BQ1)
BQ2_Avg <- moving_average(BQ2)
BQ3_Avg <- moving_average(BQ3)
PRM_Avg <- moving_average(PRM)

#Combine K,`NO3-N`, Mg, Ca, and `NH4-N` into single column called "Ion"

BQ1 <- BQ1 |>
  pivot_longer(
    cols = c(K, `NO3-N`, Mg, Ca, `NH4-N`),
    names_to = "Ion",
    values_to = "Concentration"
  )

# Turns "Ion" into a usable thing as site
# After running these lines, should turn into "factor"
class(BQ1$Ion)
BQ1 <- BQ1 |> 
  mutate(Ion = as.factor(Ion))
distinct(BQ1, Ion)
glimpse(BQ1)
# 

#I want a moving average of `NO3-N` by Sample_Date

ggplot(
  data = BQ1_Filter,
  mapping = aes(
    x = Sample_Date,
    y = Concentration
  )
) +
  geom_point() +
  geom_line()

#For BQ_2, Combine K and `NO3-N` into single column called "Chemical"

BQ2_Filter <- BQ2 |> 
  select(Sample_Date,`NO3-N`,K)
glimpse(BQ2_Filter)