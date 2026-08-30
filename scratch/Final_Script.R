library(tidyverse)
print("start")
source("R/moving-average.R")

# Store csv's into variables

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

class(BQ1$Sample_Date)
glimpse(BQ1)
colnames(BQ1)
view(BQ1)


# Filter dates to remove anything past mid 1994 (July 2, 1994) and before 1988 (Jan 1, 1988)

BQ1 <- BQ1 |> 
  filter(Sample_Date < "1994-7-2" & Sample_Date > "1987-12-31")
BQ2 <- BQ2 |> 
  filter(Sample_Date < "1994-7-2" & Sample_Date > "1987-12-31")
BQ3 <- BQ3 |> 
  filter(Sample_Date < "1994-7-2" & Sample_Date > "1987-12-31")
PRM <- PRM |> 
  filter(Sample_Date < "1994-7-2" & Sample_Date > "1987-12-31")

view(BQ1)

# Create 9 week moving average of each data set
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
    cols = c(k_mgl, mg_mgl, no3n_mgl, ca_mgl, nh4n_mgl),
    names_to = "Ion",
    values_to = "Concentration"
  )

# Factorize Ion type
Final_Data <- Final_Data |> 
  mutate(Ion = as.factor(Ion))

view(Final_Data) # Checkup
distinct(Final_Data, Ion) #Checkup

# Order Ion type correctly
#Final_Data <- factor(Ion, levels = c("k_mgl","no3n_mgl","mg_mgl","ca_mgl","nh4n_mgl"))
#distinct(Final_Data, Ion)

# Clean data output
write_csv(Final_Data, "output/clean_data.csv")


# ggplot creation

## September 19, 1989 is when Hurricane Hugo hit
HHDate <- ymd("1989-9-19")
unclass(HHDate) # you get 7201

ggplot(
  data = Final_Data,
  mapping = aes(
    x = window_start,
    y = Concentration,
    linetype = Sample_ID,
    color = Sample_ID
  )
) + 
  geom_line() +
  facet_wrap("Ion", scales = "free", ncol = 1, strip.position = "left") +
  labs(title = "Hurricane effects on stream chemistry", x = "Years") +
  geom_vline(xintercept = 7201, linetype = "longdash")