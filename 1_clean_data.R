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

#Combine data
Final_Data <- rbind(BQ1_Avg, BQ2_Avg, BQ3_Avg, PRM_Avg)

#Combine K,`NO3-N`, Mg, Ca, and `NH4-N` into single column called "Ion"
Final_Data <- Final_Data |>
  pivot_longer(
    cols = c(k_mgl, mg_mgl, no3n_mgl, ca_mgl, nh4n_mgl),
    names_to = "Ion",
    values_to = "Concentration"
  )

# Factorize Ion type
Final_Data <- Final_Data |> 
  mutate(Ion = as.factor(Ion))

# Final data output
write_csv(Final_Data, "output/clean_data.csv")