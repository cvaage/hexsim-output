# HexSim Results Plotting
# Predicted Occupancy Over Time: SMB Replicates
# cvaage@uw.edu

# SET-UP ----
library(dplyr)
library(ggplot2)
library(tidyr)
library(tidyverse)
library(sf)
library(ggspatial)


# SMB - SS ----

# LOAD DATA 

# Network file
net <- st_read("data/spatial/jdr_network/jdr_network.shp", layer = "jdr_network")
net <- net %>% 
  arrange(reachID) %>% 
  rename(RID = "reachID")

# Occupancy file
occ_ss_reps <- read_csv("output/1_smb/3.4_replicates/smb_occupancy_ss_reps.csv") #occupancy replicates


# CLEAN DATA ----

# Modify values for binned legend
occ_ss_reps <- occ_ss_reps %>% 
  mutate(Replicates = case_when(
    n_replicates_present == 0 ~ "0",
    n_replicates_present == 1 | n_replicates_present == 2 ~ "1-2",
    n_replicates_present == 3 | n_replicates_present == 4 ~ "3-4",
    n_replicates_present == 5 | n_replicates_present == 6 ~ "5-6",
    n_replicates_present == 7 | n_replicates_present == 8 ~ "7-8",
    n_replicates_present == 9 | n_replicates_present == 10 ~ "9-10"))

# Separate years of interest
bass2000 <- occ_ss_reps %>% 
  filter(Step == 12) #May 2000 = 12
bass2005 <- occ_ss_reps %>% 
  filter(Step == 72) #May 2005 = 72
bass2010 <- occ_ss_reps %>% 
  filter(Step == 132) #May 2010 = 132
bass2015 <- occ_ss_reps %>% 
  filter(Step == 192) #May 2015 = 192
bass2020 <- occ_ss_reps %>% 
  filter(Step == 252) #May 2020 = 252
bass2025 <- occ_ss_reps %>% 
  filter(Step == 300) #May 2025 = 312

# Pair with network
bass2000 <- merge(net, bass2000, by = "RID") #net must be listed first to retain geometry
bass2005 <- merge(net, bass2005, by = "RID")
bass2010 <- merge(net, bass2010, by = "RID")
bass2015 <- merge(net, bass2015, by = "RID")
bass2020 <- merge(net, bass2020, by = "RID")
bass2025 <- merge(net, bass2025, by = "RID")


# PLOTTING/MAPPING

# Set color scale for plot
bin_colors <- c("0" = "grey90",
                "1-2" = "darkseagreen1",
                "3-4" = "#a1dab4",
                "5-6" = "#41b6c4",
                "7-8" = "#2c7fb8",
                "9-10" = "#253494")

# 2000
ggplot() +
  geom_sf() +
  geom_sf(data = bass2000, aes(color = Replicates), size = 1) +
  scale_color_manual(values = bin_colors) +
  #scale_color_viridis_c() +  # or use scale_color_gradient()
  theme_minimal() +
  labs(x = 'Longitude',y = 'Latitude',
       title = 'Smallmouth bass distribution 2000', subtitle = 'Number of replicates with predicted presence by reach') +
  theme(axis.title.x = element_text(color = "grey60"),
        axis.title.y = element_text(color = "grey60"),
        axis.text = element_text(color = "grey60"),
        text = element_text(size = 16)) +
  theme(legend.position = c(0.9, 0.85),
        legend.text = element_text(size = 12),  # Legend text size
        legend.title = element_blank(),  # Legend title size
        legend.key.size = unit(0.75, "cm")) + # Legend key size
  theme(panel.background = element_blank(),
        axis.ticks = element_blank()) +
  annotation_north_arrow(location = "br", which_north = "true", 
                         height = unit(0.5, "in"), width = unit(0.5, "in"),
                         pad_y = unit(0.2, "in"),
                         style = north_arrow_fancy_orienteering) +
  annotation_scale(location = "br", width_hint = 0.2)

# 2005
ggplot() +
  geom_sf() +
  geom_sf(data = bass2005, aes(color = Replicates), size = 1) +
  scale_color_manual(values = bin_colors) +
  theme_minimal() +
  labs(x = 'Longitude',y = 'Latitude',
       title = 'Smallmouth bass distribution 2005', subtitle = 'Number of replicates with predicted presence by reach') +
  theme(axis.title.x = element_text(color = "grey60"),
        axis.title.y = element_text(color = "grey60"),
        axis.text = element_text(color = "grey60"),
        text = element_text(size = 16)) +
  theme(legend.position = c(0.9, 0.85),
        legend.text = element_text(size = 12),  # Legend text size
        legend.title = element_blank(),  # Legend title size
        legend.key.size = unit(0.75, "cm")) + # Legend key size
  theme(panel.background = element_blank(),
        axis.ticks = element_blank()) +
  annotation_north_arrow(location = "br", which_north = "true", 
                         height = unit(0.5, "in"), width = unit(0.5, "in"),
                         pad_y = unit(0.2, "in"),
                         style = north_arrow_fancy_orienteering) +
  annotation_scale(location = "br", width_hint = 0.2)

# 2010
ggplot() +
  geom_sf() +
  geom_sf(data = bass2010, aes(color = Replicates), size = 1) +
  scale_color_manual(values = bin_colors) +
  theme_minimal() +
  labs(x = 'Longitude',y = 'Latitude',
       title = 'Smallmouth bass distribution 2010', subtitle = 'Number of replicates with predicted presence by reach') +
  theme(axis.title.x = element_text(color = "grey60"),
        axis.title.y = element_text(color = "grey60"),
        axis.text = element_text(color = "grey60"),
        text = element_text(size = 16)) +
  theme(legend.position = c(0.9, 0.85),
        legend.text = element_text(size = 12),  # Legend text size
        legend.title = element_blank(),  # Legend title size
        legend.key.size = unit(0.75, "cm")) + # Legend key size
  theme(panel.background = element_blank(),
        axis.ticks = element_blank()) +
  annotation_north_arrow(location = "br", which_north = "true", 
                         height = unit(0.5, "in"), width = unit(0.5, "in"),
                         pad_y = unit(0.2, "in"),
                         style = north_arrow_fancy_orienteering) +
  annotation_scale(location = "br", width_hint = 0.2)

# 2015
ggplot() +
  geom_sf() +
  geom_sf(data = bass2015, aes(color = Replicates), size = 1) +
  scale_color_manual(values = bin_colors) +
  theme_minimal() +
  labs(x = 'Longitude',y = 'Latitude',
       title = 'Smallmouth bass distribution 2015', subtitle = 'Number of replicates with predicted presence by reach') +
  theme(axis.title.x = element_text(color = "grey60"),
        axis.title.y = element_text(color = "grey60"),
        axis.text = element_text(color = "grey60"),
        text = element_text(size = 16)) +
  theme(legend.position = c(0.9, 0.85),
        legend.text = element_text(size = 12),  # Legend text size
        legend.title = element_blank(),  # Legend title size
        legend.key.size = unit(0.75, "cm")) + # Legend key size
  theme(panel.background = element_blank(),
        axis.ticks = element_blank()) +
  annotation_north_arrow(location = "br", which_north = "true", 
                         height = unit(0.5, "in"), width = unit(0.5, "in"),
                         pad_y = unit(0.2, "in"),
                         style = north_arrow_fancy_orienteering) +
  annotation_scale(location = "br", width_hint = 0.2)

# 2020
ggplot() +
  geom_sf() +
  geom_sf(data = bass2020, aes(color = Replicates), size = 1) +
  scale_color_manual(values = bin_colors) +
  theme_minimal() +
  labs(x = 'Longitude',y = 'Latitude',
       title = 'Smallmouth bass distribution 2020', subtitle = 'Number of replicates with predicted presence by reach') +
  theme(axis.title.x = element_text(color = "grey60"),
        axis.title.y = element_text(color = "grey60"),
        axis.text = element_text(color = "grey60"),
        text = element_text(size = 16)) +
  theme(legend.position = c(0.9, 0.85),
        legend.text = element_text(size = 12),  # Legend text size
        legend.title = element_blank(),  # Legend title size
        legend.key.size = unit(0.75, "cm")) + # Legend key size
  theme(panel.background = element_blank(),
        axis.ticks = element_blank()) +
  annotation_north_arrow(location = "br", which_north = "true", 
                         height = unit(0.5, "in"), width = unit(0.5, "in"),
                         pad_y = unit(0.2, "in"),
                         style = north_arrow_fancy_orienteering) +
  annotation_scale(location = "br", width_hint = 0.2)

# 2025
ggplot() +
  geom_sf() +
  geom_sf(data = bass2025, aes(color = Replicates), size = 1) +
  scale_color_manual(values = bin_colors) +
  theme_minimal() +
  labs(x = 'Longitude',y = 'Latitude',
       title = 'Smallmouth bass distribution 2025', subtitle = 'Number of replicates with predicted presence by reach') +
  theme(axis.title.x = element_text(color = "grey60"),
        axis.title.y = element_text(color = "grey60"),
        axis.text = element_text(color = "grey60"),
        text = element_text(size = 16)) +
  theme(legend.position = c(0.9, 0.85),
        legend.text = element_text(size = 12),  # Legend text size
        legend.title = element_blank(),  # Legend title size
        legend.key.size = unit(0.75, "cm")) + # Legend key size
  theme(panel.background = element_blank(),
        axis.ticks = element_blank()) +
  annotation_north_arrow(location = "br", which_north = "true", 
                         height = unit(0.5, "in"), width = unit(0.5, "in"),
                         pad_y = unit(0.2, "in"),
                         style = north_arrow_fancy_orienteering) +
  annotation_scale(location = "br", width_hint = 0.2)


# SMB - MS ----

# LOAD DATA 

# Network file
net <- st_read("data/spatial/jdr_network/jdr_network.shp", layer = "jdr_network")
net <- net %>% 
  arrange(reachID) %>% 
  rename(RID = "reachID")

# Occupancy file
occ_ms_reps <- read_csv("output/1_smb/3.4_replicates/smb_occupancy_ms_reps.csv") #occupancy replicates


# CLEAN DATA

# Modify values for binned legend
occ_ss_reps <- occ_ss_reps %>% 
  mutate(Replicates = case_when(
    n_replicates_present == 0 ~ "0",
    n_replicates_present == 1 | n_replicates_present == 2 ~ "1-2",
    n_replicates_present == 3 | n_replicates_present == 4 ~ "3-4",
    n_replicates_present == 5 | n_replicates_present == 6 ~ "5-6",
    n_replicates_present == 7 | n_replicates_present == 8 ~ "7-8",
    n_replicates_present == 9 | n_replicates_present == 10 ~ "9-10"))

# Separate years of interest
bass2000 <- occ_ss_reps %>% 
  filter(Step == 12) #May 2000 = 12
bass2005 <- occ_ss_reps %>% 
  filter(Step == 72) #May 2005 = 72
bass2010 <- occ_ss_reps %>% 
  filter(Step == 132) #May 2010 = 132
bass2015 <- occ_ss_reps %>% 
  filter(Step == 192) #May 2015 = 192
bass2020 <- occ_ss_reps %>% 
  filter(Step == 252) #May 2020 = 252
bass2025 <- occ_ss_reps %>% 
  filter(Step == 300) #May 2025 = 312

# Pair with network
bass2000 <- merge(net, bass2000, by = "RID") #net must be listed first to retain geometry
bass2005 <- merge(net, bass2005, by = "RID")
bass2010 <- merge(net, bass2010, by = "RID")
bass2015 <- merge(net, bass2015, by = "RID")
bass2020 <- merge(net, bass2020, by = "RID")
bass2025 <- merge(net, bass2025, by = "RID")


# PLOTTING/MAPPING

# Set color scale for plot
bin_colors <- c("0" = "grey90",
                "1-2" = "darkseagreen1",
                "3-4" = "#a1dab4",
                "5-6" = "#41b6c4",
                "7-8" = "#2c7fb8",
                "9-10" = "#253494")

# 2000
ggplot() +
  geom_sf() +
  geom_sf(data = bass2000, aes(color = Replicates), size = 1) +
  scale_color_manual(values = bin_colors) +
  #scale_color_viridis_c() +  # or use scale_color_gradient()
  theme_minimal() +
  labs(x = 'Longitude',y = 'Latitude',
       title = 'Smallmouth bass distribution 2000', subtitle = 'Number of replicates with predicted presence by reach') +
  theme(axis.title.x = element_text(color = "grey60"),
        axis.title.y = element_text(color = "grey60"),
        axis.text = element_text(color = "grey60"),
        text = element_text(size = 16)) +
  theme(legend.position = c(0.9, 0.85),
        legend.text = element_text(size = 12),  # Legend text size
        legend.title = element_blank(),  # Legend title size
        legend.key.size = unit(0.75, "cm")) + # Legend key size
  theme(panel.background = element_blank(),
        axis.ticks = element_blank()) +
  annotation_north_arrow(location = "br", which_north = "true", 
                         height = unit(0.5, "in"), width = unit(0.5, "in"),
                         pad_y = unit(0.2, "in"),
                         style = north_arrow_fancy_orienteering) +
  annotation_scale(location = "br", width_hint = 0.2)

