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

BQ1_Avg <- moving_average(BQ1)
BQ2_Avg <- moving_average(BQ2)
BQ3_Avg <- moving_average(BQ3)
PRM_Avg <- moving_average(PRM)

#Add the Sample_ID column back
BQ1_Avg <- BQ1_Avg |> 
  mutate(Sample_ID = "Q1")
BQ2_Avg <- BQ2_Avg |> 
  mutate(Sample_ID = "Q2")
BQ3_Avg <- BQ3_Avg |> 
  mutate(Sample_ID = "Q3")
PRM_Avg <- PRM_Avg |> 
  mutate(Sample_ID = "PRM")

# Turn all the sites (Sample_ID's) into factors
BQ1_Avg <- BQ1_Avg |> 
  mutate(Sample_ID = as.factor(Sample_ID))
BQ2_Avg <- BQ2_Avg |> 
  mutate(Sample_ID = as.factor(Sample_ID))
BQ3_Avg <- BQ3_Avg |> 
  mutate(Sample_ID = as.factor(Sample_ID))
PRM_Avg <- PRM_Avg |> 
  mutate(Sample_ID = as.factor(Sample_ID))