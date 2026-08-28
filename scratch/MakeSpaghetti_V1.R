library(tidyverse)
print("startyessefewsfwefwe")

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

moving_average(BQ1)

#Combine K and `NO3-N` into single column called "Chemical"

BQ1_Filter <- BQ1 |> 
  select(Sample_Date,`NO3-N`,K)

glimpse(BQ1_Filter)

BQ1_Filter <- BQ1_Filter |>
  pivot_longer(
    cols = c(`NO3-N`, K),
    names_to = "Chemical",
    values_to = "Concentration"
  )

# Turns "Chemical" into a usable thing as site
# After running these lines, should turn into "factor"
class(BQ1_Filter$Chemical)
BQ1_Filter <- BQ1_Filter |> 
  mutate(Chemical = as.factor(Chemical))
distinct(BQ1_Filter, Chemical)
distinct(BQ1)
BQ1$`NO3-N`
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

# Rolling 9 week average of K

seq(ymd("2025-01-01"), ymd("2025-06-01"), by = "2 months")

# Creating the table, with dates by 9 weeks
Moving_avg <- tibble(
  window_start = seq(
    ymd(BQ2_Filter$Sample_Date[1]),
    ymd(BQ2_Filter$Sample_Date[nrow(BQ2_Filter)]),
    by = "9 weeks"
  ),
  K = NA,
  `NO3-N` = NA # Creates a blank column
  # Add more here
)

for (i in 1:nrow(Moving_avg)) {
  w1 <- Moving_avg$window_start[i]

  w2 <- w1 + weeks(9)

  K_values <- BQ2_Filter$K[
    BQ2_Filter$Sample_Date >= w1 &
      BQ2_Filter$Sample_Date < w2
  ]

  NO3_values <- BQ2_Filter$`NO3-N`[
    BQ2_Filter$Sample_Date >= w1 &
      BQ2_Filter$Sample_Date < w2
  ]

  Moving_avg$K[i] <- mean(K_values, na.rm = TRUE)
  Moving_avg$`NO3-N`[i] <- mean(NO3_values, na.rm = TRUE)
}