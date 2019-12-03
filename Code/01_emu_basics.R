# Be sure to read the Readme.Rmd document first
# All materials are available at: https://github.com/Hywel-Stoakes/EmuRSummerSchool
# An Important resource is the Emu Manual https://ips-lmu.github.io/The-EMU-SDMS-Manual/ by Raphael Winkelmann
#### Introduction ####
require(emuR)
## Not run:
# create demo data including an emuDB called "ae"
# for a local project change the path (each folder inside its own parentheses)
create_emuRdemoData(dir = file.path("DATA"))

# construct path to demo emuDB
# On Rstudio Cloud
# path2ae = file.path("/cloud/project/DATA", "emuR_demoData", "ae_emuDB")
# Local (From Github)
path2ae = file.path("DATA", "emuR_demoData", "ae_emuDB")

# load emuDB into current R session
ae = load_emuDB(path2ae)
serve(ae) # This command doesn't work Rstudio cloud - locally this will take a little time
# query loaded emuDBh
lvowels = query(ae, "Phonetic = i: | u: | o:")

# extract labels from query result
label <- function(x){
  x$labels
}

lvowels.labs = label(lvowels)

# list all ssffTrackDefinitions of emuDB
list_ssffTrackDefinitions(ae)
summary(ae)

# get formant trackdata defined in ssffTrackDefinitions "fm" for query result
# extract track values at temporal midpoint of segments
lvowels.fm = get_trackdata(ae, lvowels, "fm",cut = 0.5)

# Plot the data

