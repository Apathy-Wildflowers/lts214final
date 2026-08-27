# Automate
## Not yet
Right now, it appears data reading and cleaning is occurring in the paper.qmd file instead of in a standalone script - some of this can likely be moved into a separate "1_clean_data.R" script and then loaded into the qmd. 

One note is that the moving average function definition looks great but is currently in two places - both in the standalone moving-average.R script, as well as in the paper.qmd file. It might be more clear for the reader to only have the moving average function in the moving-average.R script, and then referenced in the paper.qmd file (through source("R/moving-average.R"))

The only other thing paper.qmd needs is the code to create a figure.

# Organize 
## Not yet
The file management and code is really well organized, looks great, and satisfies almost all specs. Only thing missing seems to be an output folder, which can eventually house the .csv from "1_clean_data.R" 

# Document
## Not yet
The README is off to a great start, it is just missing a few pieces:
- A concise description of what’s housed in the repository
- A list of authors or current contributors (for collaborative work)
- Some additional details on data access (the EDI is linked but it might be helpful to describe which datasets from that site are used in this analysis, and what steps need to be taken in order to run the code locally)

The code style looks consistent and has an appropriate amount of comments so far.


