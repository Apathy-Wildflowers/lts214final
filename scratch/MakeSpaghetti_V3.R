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

#Add the Sample_ID column back
BQ1_Avg <- BQ1_Avg |> 
  mutate(Sample_ID = "Q1")
BQ2_Avg <- BQ2_Avg |> 
  mutate(Sample_ID = "Q2")
BQ3_Avg <- BQ3_Avg |> 
  mutate(Sample_ID = "Q3")
PRM_Avg <- PRM_Avg |> 
  mutate(Sample_ID = "PRM")

glimpse(PRM_Avg) # Checkup
# Turn all the sites (Sample_ID's) into factors

BQ1_Avg <- BQ1_Avg |> 
  mutate(Sample_ID = as.factor(Sample_ID))
BQ2_Avg <- BQ2_Avg |> 
  mutate(Sample_ID = as.factor(Sample_ID))
BQ3_Avg <- BQ3_Avg |> 
  mutate(Sample_ID = as.factor(Sample_ID))
PRM_Avg <- PRM_Avg |> 
  mutate(Sample_ID = as.factor(Sample_ID))

distinct(BQ1_Avg, Sample_ID) #Checkup
class(BQ1_Avg$Sample_ID) #Checkup

#Combine data
Final_Data <- rbind(BQ1_Avg, BQ2_Avg, BQ3_Avg, PRM_Avg)

glimpse(Final_Data) # Checkup
distinct(Final_Data, Sample_ID) #Checkup

#Combine K,`NO3-N`, Mg, Ca, and `NH4-N` into single column called "Ion"

Final_Data <- Final_Data |>
  pivot_longer(
    cols = c(K, `NO3-N`, Mg, Ca, `NH4-N`),
    names_to = "Ion",
    values_to = "Concentration"
  )


# ggplot yeah creation

ggplot(
  data = BQ1_Avg,
  mapping = aes(
    x = Sample_Date,
    y = Concentration
  )
) +
  geom_point() +
  geom_line()