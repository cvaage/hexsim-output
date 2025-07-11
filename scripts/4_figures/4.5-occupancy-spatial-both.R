# HexSim Results Plotting
# Occupancy Over Time: Multispecies Models
# cvaage@uw.edu

#

# SET-UP ----
library(dplyr)
library(tidyr)
library(tidyverse)
library(sf)

library(ggplot2)
library(gganimate);library(animation)

# LOAD DATA ----

# Network file
net <- st_read("data/spatial/jdr_network/jdr_network.shp", layer = "jdr_network")
net <- net %>% 
  arrange(reachID) %>% 
  rename(RID = "reachID")

# Occupancy files
smb <- read_csv("output/1_smb/3.4_replicates/smb_occupancy_ms_reps.csv")
rc <- read_csv("output/2_rc/3.4_replicates/rc_occupancy_ms_reps.csv")


# PLOTTING PREP ----

# Modify values in bass to 1, crayfish to 2
bass_complete[bass_complete > 0] <- 1
cray_complete[cray_complete > 0] <- 2
bass_complete$RID <- full_sequence
cray_complete$RID <- full_sequence

# Combine SMB and RC data
# 1 = only bass, 2 = only cray, 3 = both, 0 = neither
combined_complete <- bass_complete[,c(2:251)] + cray_complete[,c(2:251)]
max(combined_complete) #QA/QC
combined_complete$RID <- reaches #add reaches ID back in
combined_complete_long <- combined_complete %>%
  pivot_longer(cols = starts_with("X"),  # Specify columns to pivot
               names_to = "Date",            # Name of the new column for the old column names
               names_prefix = "X",       # Prefix to remove from names (optional)
               values_to = "Occupancy")          # Name of the new column for the values

combined_char <- combined_complete_long %>%
  mutate(Category = case_when(
    Occupancy == 0 ~ "Unoccupied",
    Occupancy == 1 ~ "Bass Present",
    Occupancy == 2 ~ "Crayfish Present",
    Occupancy == 3 ~ "Co-Occupied"
  ))

combined_char <- combined_char[,-3] #remove Occupancy column
combined_char_wide <- combined_char %>%
  pivot_wider(
    names_from = Date,     # Column to become new columns
    values_from = Category    # Column to fill the new columns
  )

combined_char_wide <- combined_char_wide[,-1] #remove RID column

dates <- seq(as.Date('1999-05-01'), by = "month", length.out = 250)
colnames(combined_char_wide) <- dates #replace column headers, steps with dates

combined_char_wide$RID <- reaches #add reaches ID back in

#merge with sf object
occupancy <- net %>%
  left_join(combined_char_wide, by = "RID")


# PLOTTING ----

# Define limits
start <- which(names(occupancy)=="1999-05-01")
end <- which(names(occupancy)=="2020-02-01")

custom_colors <- c("Unoccupied" = "lightblue", "Bass Present" = "goldenrod", "Crayfish Present" = "darkred", "Co-Occupied" = "darkorange")

# Generate and save plots for each date
saveGIF({
  for(i in start:end){
    drops <- c("geometry") # list of col names
    lay <- occupancy[,i]
    presence <- data.frame(lay)[,!(names(lay) %in% drops)] #remove columns "geometry"
    
    p <- ggplot() +
      geom_sf() +
      geom_sf(data = occupancy, aes(color = presence)) +
      scale_color_manual(values = custom_colors) +
      ggtitle(names(lay)[1]) +
      labs(x='Longitude',y='Latitude',
           title = 'Species Occupancy 1999-2020', subtitle = 'Reach-level Presence-Absence', 
           caption = 'FigureX. Presence (0 <= X Individuals) of Smallmouth Bass and Rusty Crayfish across the John Day River, OR, as represented within HexSim') + 
      theme(axis.title.x = element_text(color = "grey60"),
            axis.title.y = element_text(color = "grey60"),
            axis.text = element_text(color = "grey60"),
            text=element_text(size=12)) +
      theme(legend.text = element_text(size = 14),  # Legend text size
            legend.title = element_text(size = 16),  # Legend title size
            legend.key.size = unit(1.5, "cm"),  # Legend key size
            legend.box.size = 1.5, # Overall legend box size
            legend.position=c(0.8, 0.2)) + # legend position in plot
      scale_fill_discrete(name='ExperimentalCondition',
                          breaks=c('Bass', 'Crayfish', 'Both.Species', 'Neither.Species'),
                          labels=c('M. dolomieu', 'F. rusticus', 'Co-Occupied', 'Un-Occupied')) +
      annotation_north_arrow(location = "br", which_north = "true", 
                             height = unit(0.5, "in"), width = unit(0.5, "in"),
                             pad_y = unit(0.2, "in"),
                             style = north_arrow_fancy_orienteering) + 
      annotation_scale(location = "br", width_hint = 0.2)
    theme_minimal()
    print(p)
  }
  
}, movie.name = "/Volumes/LaCie/HexSim Results/Figures/output/OccupancyOverTimeTest.gif", interval = 1, ani.width = 1000, ani.height = 700)
