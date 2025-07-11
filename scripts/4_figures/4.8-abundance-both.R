# HexSim Results Processing: Smallmouth Bass
# Abundance Over Time: Single vs. Multiple Species Models
# cvaage@uw.edu

#

# SET-UP ----

library(dplyr)
library(tidyr)
library(tidyverse)
library(ggplot2)


# READ IN DATA ----

# Add average abundance files
smb <- read_csv("output/1_smb/3.4_replicates/smb_abundance_ms_s_reps.csv")
rc <- read_csv("output/2_rc/3.4_replicates/rc_abundance_ms_s_reps.csv")

# PLOTTING PREP ----

# Add columns to define species
smb$Species <- "SMB"
rc$Species <- "RC"

# Combine into single data frame
both <- merge(smb, rc, by = "Step")


# PLOTTING ----

ggplot(bassboth, aes(x = `Time Step`, y = Mean, group = Model)) +
  geom_ribbon(aes(ymin = Mean - SD, ymax = Mean + SD),
              fill = "gray50",
              alpha = 0.5) +
  geom_line(color = "black", size = 1) +
  geom_vline(xintercept = 120, color = "salmon", linetype = "dashed", linewidth = 1) +
  theme(strip.background = element_rect(fill = NA, color = NA),
        panel.background = element_rect(fill=NA, color="gray60"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.spacing.x=unit(0, "lines"),
        panel.spacing.y=unit(0, "lines"),
        strip.text = element_blank()) +
  scale_x_continuous(expand = c(0, 0),
                     breaks = plotbreaks,
                     labels = plotlabels) + 
  scale_y_continuous(expand = c(0, 0)) +
  ylab("Abundance") +
  xlab("Years") +
  theme(axis.title.x = element_text(size = 18, face = "bold"),
        axis.title.y = element_text(size = 18, face = "bold"),
        axis.text.x = element_text(size = 14),
        axis.text.y = element_text(size = 14))
bassmulti


# EXPORT ----

ggsave("output/figure1.3b.png", plot = bassmulti, width = 8, height = 8, dpi = 300)
