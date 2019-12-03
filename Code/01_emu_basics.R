# Be sure to read the Readme.Rmd document first
# All materials are available at: https://github.com/Hywel-Stoakes/EmuRSummerSchool
# An Important resource is the Emu Manual https://ips-lmu.github.io/The-EMU-SDMS-Manual/ by Raphael Winkelmann
require(emuR)
## Not run: 
# create demo data including an emuDB called "ae" 
# for a local project change the path (each folder inside its own parentheses)
create_emuRdemoData(dir = file.path("/","cloud","project","DATA"))

# construct path to demo emuDB
path2ae = file.path("/cloud/project/DATA", "emuR_demoData", "ae_emuDB")

# load emuDB into current R session
ae = load_emuDB(path2ae)
serve(ae) # This command doesn't work Rstudio cloud
# query loaded emuDB
lvowels = query(ae, "Phonetic = i: | u: | o:")

# extract labels from query result 
#### NEED to Update this function ####
label <- function(x){
  x$labels
}

lvowels.labs = label(lvowels)

# list all ssffTrackDefinitions of emuDB
list_ssffTrackDefinitions(ae)

# get formant trackdata defined in ssffTrackDefinitions "fm" for query result
# extract track values at temporal midpoint of segments
lvowels.fm = get_trackdata(ae, lvowels, "fm",cut = 0.5)

# Plot the data

