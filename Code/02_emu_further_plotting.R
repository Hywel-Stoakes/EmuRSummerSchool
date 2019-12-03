require(emuR)
## Run This if you have not yet loaded the ae database
# create demo data including an emuDB called "ae"
# for a local project change the path (each folder inside its own parentheses)
# create_emuRdemoData(dir = file.path("/","cloud","project","DATA"))
#
# construct path to demo emuDB
# path2ae = file.path("/cloud/project/DATA", "emuR_demoData", "ae_emuDB")
#
# load emuDB into current R session
# ae = load_emuDB(path2ae)
# serve(ae) # This command doesn't work Rstudio cloud

require(tidyverse)
# query A and V (front and back open vowels),
# i:and u: (front and back closed vowels), and
# E and o: (front and back mid vowels)
ae_vowels = query(emuDBhandle = ae,
                  query = "[Phonetic == V | A | i: | u: | o: | E]")
#get the formants:
ae_formants = get_trackdata(ae,
                            seglist = ae_vowels,
                            ssffTrackName = "fm",
                            resultType = "tibble")

# extract the temporal mid-points
ae_midpoints = ae_formants %>%
  filter(times_norm == 0.5)

# plot using facet_wrap()
# to plot vowels separately for every bundle
# query A and V (front and back open vowels),
# i:and u: (front and back closed vowels), and
# E and o: (front and back mid vowels)
ae_vowels = query(emuDBhandle = ae,
                  query = "[Phonetic == V | A | i: | u: | o: | E]")
#get the formants:
ae_formants = get_trackdata(ae,
                            seglist = ae_vowels,
                            ssffTrackName = "fm",
                            resultType = "tibble")

# extract the temporal mid-points
ae_midpoints = ae_formants %>%
  filter(times_norm == 0.5)

# plot using facet_wrap()
# to plot vowels separately for every bundle
# (this assumes that every bundle contains a different
# speaker which is actually not the case in the ae emuDB)
ggplot(ae_midpoints) +
  aes(x = T2, y = T1, label = labels, col = labels) +
  geom_text() +
  scale_y_reverse() + scale_x_reverse() +
  labs(x = "F2 (Hz)", y = "F1 (Hz)") +
  theme(legend.position = "none") +
  facet_wrap(~bundle)
