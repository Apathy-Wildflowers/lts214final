library(tidyverse)
#The real
# K, `NO3-N`, Mg, Ca, `NH4-N`

# The input to this function should be a data frame containing stream chemistry data
moving_average <- function(DataSet) {
  # Initialize a tibble to contain the results
  result <- tibble (
    window_start = seq(ymd(DataSet$Sample_Date[1]), ymd(DataSet$Sample_Date[nrow(DataSet)]),  by = "9 weeks"),
    k_mgl = NA,
    mg_mgl = NA,
    no3n_mgl = NA,
    ca_mgl = NA,
    nh4n_mgl = NA,
    Site_ID = NA
    # Fill in the rest of the ions
  )

  # Fill in the iterator and sequence
  for (i in 1:nrow(result)) {
    # Create variables for the start and end of the current window
    w1 <- result$window_start[i]
    w2 <- w1 + weeks(9)

    # Create a logical vector, called "in_window", that says which samples are inside the window
    # Hint: you'll compare sample dates to the start and end of the window
    in_window <- DataSet$Sample_Date[DataSet$Sample_Date >= w1 &
      DataSet$Sample_Date < w2]

    # Use indexing to pull out the ion concentrations that fall inside the window
    k_window <- DataSet$k[DataSet$Sample_Date >= w1 & DataSet$Sample_Date < w2]
    no3n_window <- DataSet$`NO3-N`[DataSet$Sample_Date >= w1 & DataSet$Sample_Date < w2]
    mg_window <- DataSet$Mg[DataSet$Sample_Date >= w1 & DataSet$Sample_Date < w2]
    ca_window <- DataSet$Ca[DataSet$Sample_Date >= w1 & DataSet$Sample_Date < w2]
    nh4n_window <- DataSet$`NH4-N`[DataSet$Sample_Date >= w1 & DataSet$Sample_Date < w2]

    # The line above gets potassium in the window. Get the rest of the ions too

    # Calculate the mean of each ion concentration and fill in the result
    result$k_mgl[i] <- mean(k_window, na.rm = TRUE)
    result$no3n_mgl[i] <- mean(no3n_window, na.rm = TRUE)
    result$mg_mgl[i] <- mean(mg_window, na.rm = TRUE)
    result$ca_mgl[i] <- mean(ca_window, na.rm = TRUE)
    result$nh4n_mgl[i] <- mean(nh4n_window, na.rm = TRUE)
  }
  return(result)
  # Return the result
}

