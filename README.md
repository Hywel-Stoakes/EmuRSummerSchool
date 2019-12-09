---
output:
  pdf_document: default
  html_document: default
---
# Welcome to the CoEDL Summer School
Here are the support files for the EmuR Workshop at the CoEDL Summer School 2019

## The Emu R course

This is a gentle introduction to Emu R and using R studio for speech science and phonetics. This document will help you install R, Rstudio and EmuR which are pre-requisites for this course.

## Installation
If you don't have R and R studio installed, please follow the steps described in this document (and see the wiki for further info).

### Installing R
1. The first step is to install R from this url: https://cran.ms.unimelb.edu.au
2. Download the correct binary for your platform:
3. Follow the installation instructions (Install RTools if you are on Windows)

### Installing R Studio
We require the open source version of RStudio Desktop.

https://rstudio.com/products/rstudio/download/#download

If you don't already have EmuR Installed you can install it using:

```{r installation_emu}
# install.packages('devtools')
install.packages('tidyverse') # Required for emu
install.packages('emuR')
```

```{r}
# If we want the development version of emuR we can use the following code:
# library(devtools)
# install_github("IPS-LMU/emuR")
```

Please open the `Code` folder and goto `01_emu_basics.R` and then to `02_emu_further_plotting.R`.

Once you have worked through those files then you can take a look at the import and export instructions in the `Docs` folder. All of these files will open in RStudio.

For further information and guides on how to add formants and fundamental frequency information, take a look at the Wiki (https://github.com/Hywel-Stoakes/EmuRSummerSchool/wiki)

For further information see the [Emu SDMS Manual by Raphael Winkelmann:
https://ips-lmu.github.io/The-EMU-SDMS-Manual/](https://ips-lmu.github.io/The-EMU-SDMS-Manual/)

A great general resource for using R for Data Science is *R for Data Science* by Garrett Grolemund and Hadley Wickham
(read online at: [https://r4ds.had.co.nz](https://r4ds.had.co.nz))

Please contact me if you have any questions: hstoakes at unimelb dot edu.au
