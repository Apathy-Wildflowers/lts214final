# Recreating Figure 3 from Schaefer et al. (2000)

## Description

This project recreates a graph that shows chemical concentrations before and after Hurricane Hugo in 4 streams in Bisley, Puerto Rico.
More specifically, it recreates Figure 3. from "Effects of Hurricane Disturbance on Stream Water Concentrations and Fluxes in Eight Tropical Forest Watersheds of the Luquillo Experimental Forest, Puerto Rico" by Douglas A. Schaefer, William H. McDowell, Fredrick N. Scatena and Clyde E. Asbury (2000) [https://doi.org/10.1017/s0266467400001358]

## Repository Format

/data/
Has all the raw data outputs

/docs/
Contains paper.html and paper_files

/output/
Contains the output of the cleaned data read to be graphed

/paper/
Contains paper.qmd and _quarto.yml for webpage creation

/R/
Contains single function moving-average.R

/scratch/
Contains 3 major versions of main code along with final version of script

peer-assessment.md
Contains Courtney's assessment of my repo of my ability to fill out the project specs

self-asssessment.md
Contains my assessment of my repo of my ability to fill out the project specs

## Data

Data is taken from the Environmental Data Initiative [https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-luq.20.4923064]

The four stream data are taken from the folder "data/knb-lter-luq.20.4923064" and are as follows:
-QuebradaCuenca1-Bisley.csv
-QuebradaCuenca2-Bisley.csv
-QuebradaCuenca3-Bisley.csv
-RioMameyesPuenteRoto.csv

## Authors
Liam Sarmiento

## References

https://doi.org/10.1017/s0266467400001358

https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-luq.20.4923064
