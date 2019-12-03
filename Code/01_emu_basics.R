# Be sure to read the Readme.Rmd document first
# All materials are available at: https://github.com/Hywel-Stoakes/EmuRSummerSchool
# An Important resource is the Emu Manual https://ips-lmu.github.io/The-EMU-SDMS-Manual/ by Raphael Winkelmann
#### Introduction ####
require(emuR)
## Not run:
# create demo data including an emuDB called "ae"
# for a local project change the path (each folder inside its own parentheses)
# create_emuRdemoData(dir = file.path("/","cloud","project","DATA")) # on RStudio Cloud
create_emuRdemoData(dir = file.path("DATA"))                         # Local project

#### construct path to demo emuDB ###

# path2ae = file.path("/cloud/project/DATA", "emuR_demoData", "ae_emuDB") # On Rstudio Cloud
path2ae = file.path("DATA", "emuR_demoData", "ae_emuDB") # Local (From Github)

#### load emuDB into current R session ####
ae = load_emuDB(path2ae)
serve(ae) # This command doesn't work Rstudio cloud - locally this will take a little time

#### A couple of useful functions ####
seg_label <- function(x){
  x$labels
}

seg_dur <- function(x){
  x$end - x$start
}

#### An example to plot vowels in two-dimensions ####
require(tidyverse)
# query A and V (front and back open vowels),
# i:and u: (front and back closed vowels), and
# E and o: (front and back mid vowels)
# Labels are in machine readable ASCII (could be IPA or any other Unicode symbol)
ae_vowels = query(emuDBhandle = ae,
                  query = "[Phonetic == V | A | i: | u: | o: | E]")

# get the formants:
ae_formants = get_trackdata(ae,
                            seglist = ae_vowels,
                            ssffTrackName = "fm",
                            resultType = "tibble")

# time normalize the formant values
ae_formants_norm = normalize_length(ae_formants)

# extract the temporal mid-points
ae_midpoints = ae_formants_norm %>%
  filter(times_norm == 0.5)

# plot F1 & F2 values (== eplot(..., dopoints = T, doellipse = F, centroid = F, ...))
ggplot(ae_midpoints) +
  aes(x = T2, y = T1, label = labels, col = labels) +
  geom_text() +
  scale_y_reverse() + scale_x_reverse() +
  labs(x = "F2 (Hz)", y = "F1 (Hz)") +
  theme(legend.position = "none")

# plot F1 & F2 values (== eplot(..., dopoints = T, doellipse = T, centroid = F, ...))
ggplot(ae_midpoints) +
  aes(x = T2, y = T1, label = labels, col = labels) +
  geom_text() +
  stat_ellipse() +
  scale_y_reverse() + scale_x_reverse() +
  labs(x = "F2 (Hz)", y = "F1 (Hz)") +
  theme(legend.position = "none")

# filter out vowels with enough data points
# the %>% operator comes from the magrittr package “Ceci n’est pas une pipe”
# to calc. ellipse
ae_midpoints_Eiu = ae_midpoints %>% filter(labels%in%c("E","i:","u:"))

ae_centroid = ae_midpoints_Eiu %>%
  group_by(labels) %>%
  summarise(T1 = mean(T1), T2 = mean(T2))

# plot F1 & F2 values (== eplot(..., dopoints = T, doellipse = T, centroid = T, ...))
ggplot(ae_midpoints_Eiu) +
  aes(x = T2, y = T1, label = labels, col = labels) +
  stat_ellipse() +
  scale_y_reverse() + scale_x_reverse() +
  labs(x = "F2 (Hz)", y = "F1 (Hz)") +
  theme(legend.position = "none") +
  geom_text(data = ae_centroid)
