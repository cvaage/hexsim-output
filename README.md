**HexSim Output**

Processing output, reviewing results, and generating figures, as presented in:

_Citation to be added_

Contacts: cvaage@uw.edu

README.md structure adapted from github.com/aimeefullerton/daily-st-pnw
  
--------------------------------------------------------------------------------

STEP I: Set up.

Follow these steps to download software, model input files, and packages required to replicate our process. 

Hardware Specifications:
- 64-bit Windows operating system
- 12 Intel and Xeon CPU cores (3.60 GHz) and 192 GB RAM
- 2 TB for data storage (and more for virtual RAM)

Notes:
- Scripts do not need to be run sequentially as indicated by file names, but certain output will need to be generated prior to running later scripts.
- Output, including census events and data probes, will vary by each model. Modifications to the script (i.e., modifying column names) will have to be made.

To Start:
1.	Download and install R and RStudio or other GUI.
2.	Clone or download this repository as a new project.
3.	Package libraries called from our scripts that may need to be installed prior to running include: 

--------------------------------------------------------------------------------

STEP II: Run scripts to summarize results and prepare data that will be needed for plotting. 

All scripts are found in the folder ‘scripts-results’. Each of the following subfolders has a series of scripts that may need to be run sequentially, depending on scope of interest. The end of this file contains more information about what data are read in and written out by each script.

scripts-results/
 * 1_smb/
 * 2_rc/
 * 3_both/
 
--------------------------------------------------------------------------------

Expected structure of the ‘data’ directory is below.

data/
* smb/ single-species model output for smallmouth bass 
* rc/  single-species model output for rusty crayfish
* multispecies/ multi-species model output for smallmouth bass and rusty crayfish
* spatial/ network data files with attributes
* sensitivity/ select model output for sensitivity analyses

--------------------------------------------------------------------------------

STEP III: Run scripts to produce plots.

scripts-results/4_figures/
* 4.1-occupancy-spatial-smb
* 4.2-occupancy-trendline-smb
* 4.3-occupancy-spatial-rc
* 4.4-occupancy-trendline-rc
* 4.5-occupancy-spatial-both
* 4.6-abundance-smb
* 4.7-abundance-rc
* 4.8-abundance-both

--------------------------------------------------------------------------------

List of scripts, including names of data files that are read and written, for preparing and plotting model output in R.

**data**

**/1_smb**

_**1.1-occupancy-over-time-ss.R**_

READS:
* data/smb/scenario/dataprobe/monthly

WRITES:
* output/1_smb/1.1_smb_occupancy_ss/smb_occupancy_ss_1
* output/1_smb/1.1_smb_occupancy_ss/smb_occupancy_ss_2
* output/1_smb/1.1_smb_occupancy_ss/smb_occupancy_ss_3
* output/1_smb/1.1_smb_occupancy_ss/smb_occupancy_ss_4
* output/1_smb/1.1_smb_occupancy_ss/smb_occupancy_ss_5
* output/1_smb/1.1_smb_occupancy_ss/smb_occupancy_ss_6
* output/1_smb/1.1_smb_occupancy_ss/smb_occupancy_ss_7
* output/1_smb/1.1_smb_occupancy_ss/smb_occupancy_ss_8
* output/1_smb/1.1_smb_occupancy_ss/smb_occupancy_ss_9
* output/1_smb/1.1_smb_occupancy_ss/smb_occupancy_ss_10

_**1.2-occupancy-over-time-ms.R**_

READS:
* data/multispecies/scenario/monthly_smb

WRITES:
* output/1_smb/1.2_smb_occupancy_ms/smb_occupancy_ms_1
* output/1_smb/1.2_smb_occupancy_ms/smb_occupancy_ms_2
* output/1_smb/1.2_smb_occupancy_ms/smb_occupancy_ms_3
* output/1_smb/1.2_smb_occupancy_ms/smb_occupancy_ms_4
* output/1_smb/1.2_smb_occupancy_ms/smb_occupancy_ms_5
* output/1_smb/1.2_smb_occupancy_ms/smb_occupancy_ms_6
* output/1_smb/1.2_smb_occupancy_ms/smb_occupancy_ms_7
* output/1_smb/1.2_smb_occupancy_ms/smb_occupancy_ms_8
* output/1_smb/1.2_smb_occupancy_ms/smb_occupancy_ms_9
* output/1_smb/1.2_smb_occupancy_ms/smb_occupancy_ms_10

_**1.3-density-over-time-ss.R**_

READS:
* data/smb/scenario/density

WRITES:
* output/1_smb/1.3_smb_density_ss/smb_density_ss_1
* output/1_smb/1.3_smb_density_ss/smb_density_ss_2
* output/1_smb/1.3_smb_density_ss/smb_density_ss_3
* output/1_smb/1.3_smb_density_ss/smb_density_ss_4
* output/1_smb/1.3_smb_density_ss/smb_density_ss_5
* output/1_smb/1.3_smb_density_ss/smb_density_ss_6
* output/1_smb/1.3_smb_density_ss/smb_density_ss_7
* output/1_smb/1.3_smb_density_ss/smb_density_ss_8
* output/1_smb/1.3_smb_density_ss/smb_density_ss_9
* output/1_smb/1.3_smb_density_ss/smb_density_ss_10

_**1.4-density-over-time-ms.R**_

READS:
* data/multispecies/density_smb.csv

WRITES:
* output/1_smb/1.4_smb_density_ms/smb_density_ms_1
* output/1_smb/1.4_smb_density_ms/smb_density_ms_2
* output/1_smb/1.4_smb_density_ms/smb_density_ms_3
* output/1_smb/1.4_smb_density_ms/smb_density_ms_4
* output/1_smb/1.4_smb_density_ms/smb_density_ms_5
* output/1_smb/1.4_smb_density_ms/smb_density_ms_6
* output/1_smb/1.4_smb_density_ms/smb_density_ms_7
* output/1_smb/1.4_smb_density_ms/smb_density_ms_8
* output/1_smb/1.4_smb_density_ms/smb_density_ms_9
* output/1_smb/1.4_smb_density_ms/smb_density_ms_10

_**1.5-dispersal-over-time-ss.R**_

READS:
* data/spatial/jdr_sections
* output/1_smb/1.1_smb_occupancy_ss/smb_occupancy_ss_1 TO output/1_smb/1.1_smb_occupancy_ss/smb_occupancy_ss_10

WRITES:
* output/1_smb/1.5_smb_dispersal_ss_1
* output/1_smb/1.5_smb_dispersal_ss_2
* output/1_smb/1.5_smb_dispersal_ss_3
* output/1_smb/1.5_smb_dispersal_ss_4
* output/1_smb/1.5_smb_dispersal_ss_5
* output/1_smb/1.5_smb_dispersal_ss_6
* output/1_smb/1.5_smb_dispersal_ss_7
* output/1_smb/1.5_smb_dispersal_ss_8
* output/1_smb/1.5_smb_dispersal_ss_9
* output/1_smb/1.5_smb_dispersal_ss_10

_**1.6-dispersal-over-time-ms.R**_

READS:
* data/spatial/jdr_sections
* output/1_smb/1.2_smb_occupancy_ms/smb_occupancy_ms_1 TO output/1_smb/1.2_smb_occupancy_ms/smb_occupancy_ms_10

WRITES:
* output/1_smb/1.6_smb_dispersal_ms_1
* output/1_smb/1.6_smb_dispersal_ms_2
* output/1_smb/1.6_smb_dispersal_ms_3
* output/1_smb/1.6_smb_dispersal_ms_4
* output/1_smb/1.6_smb_dispersal_ms_5
* output/1_smb/1.6_smb_dispersal_ms_6
* output/1_smb/1.6_smb_dispersal_ms_7
* output/1_smb/1.6_smb_dispersal_ms_8
* output/1_smb/1.6_smb_dispersal_ms_9
* output/1_smb/1.6_smb_dispersal_ms_10

_**1.7-abundance-replicates.R**_

READS:
* output/1_smb/1.1_smb_occupancy_ss/smb_occupancy_ss_1 TO output/1_smb/1.1_smb_occupancy_ss/smb_occupancy_ss_10
* output/1_smb/1.2_smb_occupancy_ms/smb_occupancy_ms_1 TO output/1_smb/1.2_smb_occupancy_ms/smb_occupancy_ms_10

WRITES: 
* output/1_smb/3.4_replicates/smb_abundance_ss_s_reps.csv
* output/1_smb/3.4_replicates/smb_abundance_ss_r_reps.csv
* output/1_smb/3.4_replicates/smb_abundance_ms_s_reps.csv
* output/1_smb/3.4_replicates/smb_abundance_ms_r_reps.csv

_**1.8-occupancy-replicates.R**_

READS:
* output/1_smb/1.1_smb_occupancy_ss/smb_occupancy_ss_1 TO output/1_smb/1.1_smb_occupancy_ss/smb_occupancy_ss_10
* output/1_smb/1.2_smb_occupancy_ms/smb_occupancy_ms_1 TO output/1_smb/1.2_smb_occupancy_ms/smb_occupancy_ms_10

WRITES: 
* output/1_smb/3.4_replicates/smb_occupancy_ss_reps.csv
* output/1_smb/3.4_replicates/smb_occupancy_ms_reps.csv

_**1.9-density-replicates.R**_

READS: 
* output/1_smb/1.3_smb_density_ss/smb_density_ss_1 TO output/1_smb/1.3_smb_density_ss/smb_density_ss_10
* output/1_smb/1.4_smb_density_ms/smb_density_ms_1 TO output/1_smb/1.4_smb_density_ms/smb_density_ms_10

WRITES:
* output/1_smb/3.4_replicates/smb_density_ss_reps
* output/1_smb/3.4_replicates/smb_density_ms_reps

**/2_rc**

_**2.1-occupancy-over-time-ss.R**_

READS:
* data/rc/scenario/dataprobe/monthly

WRITES:
* output/2_rc/2.1_rc_occupancy_ss/rc_occupancy_ss_1
* output/2_rc/2.1_rc_occupancy_ss/rc_occupancy_ss_2
* output/2_rc/2.1_rc_occupancy_ss/rc_occupancy_ss_3
* output/2_rc/2.1_rc_occupancy_ss/rc_occupancy_ss_4
* output/2_rc/2.1_rc_occupancy_ss/rc_occupancy_ss_5
* output/2_rc/2.1_rc_occupancy_ss/rc_occupancy_ss_6
* output/2_rc/2.1_rc_occupancy_ss/rc_occupancy_ss_7
* output/2_rc/2.1_rc_occupancy_ss/rc_occupancy_ss_8
* output/2_rc/2.1_rc_occupancy_ss/rc_occupancy_ss_9
* output/2_rc/2.1_rc_occupancy_ss/rc_occupancy_ss_10

_**2.2-occupancy-over-time-ms.R**_

READS:
* data/multispecies/scenario/monthly_rc

WRITES:
* output/2_rc/2.2_rc_occupancy_ms/rc_occupancy_ms_1
* output/2_rc/2.2_rc_occupancy_ms/rc_occupancy_ms_2
* output/2_rc/2.2_rc_occupancy_ms/rc_occupancy_ms_3
* output/2_rc/2.2_rc_occupancy_ms/rc_occupancy_ms_4
* output/2_rc/2.2_rc_occupancy_ms/rc_occupancy_ms_5
* output/2_rc/2.2_rc_occupancy_ms/rc_occupancy_ms_6
* output/2_rc/2.2_rc_occupancy_ms/rc_occupancy_ms_7
* output/2_rc/2.2_rc_occupancy_ms/rc_occupancy_ms_8
* output/2_rc/2.2_rc_occupancy_ms/rc_occupancy_ms_9
* output/2_rc/2.2_rc_occupancy_ms/rc_occupancy_ms_10

_**2.3-density-over-time-ss.R**_

READS:
* data/rc/scenario/dataprobe/monthly

WRITES:
* output/2_rc/2.3_rc_density_ss/rc_density_ss_1
* output/2_rc/2.3_rc_density_ss/rc_density_ss_2
* output/2_rc/2.3_rc_density_ss/rc_density_ss_3
* output/2_rc/2.3_rc_density_ss/rc_density_ss_4
* output/2_rc/2.3_rc_density_ss/rc_density_ss_5
* output/2_rc/2.3_rc_density_ss/rc_density_ss_6
* output/2_rc/2.3_rc_density_ss/rc_density_ss_7
* output/2_rc/2.3_rc_density_ss/rc_density_ss_8
* output/2_rc/2.3_rc_density_ss/rc_density_ss_9
* output/2_rc/2.3_rc_density_ss/rc_density_ss_10

_**2.4-density-over-time-ms.R**_

READS:
* data/multispecies/scenario/monthly_rc

WRITES:
* output/2_rc/2.4_rc_density_ms/rc_density_ms_1
* output/2_rc/2.4_rc_density_ms/rc_density_ms_2
* output/2_rc/2.4_rc_density_ms/rc_density_ms_3
* output/2_rc/2.4_rc_density_ms/rc_density_ms_4
* output/2_rc/2.4_rc_density_ms/rc_density_ms_5
* output/2_rc/2.4_rc_density_ms/rc_density_ms_6
* output/2_rc/2.4_rc_density_ms/rc_density_ms_7
* output/2_rc/2.4_rc_density_ms/rc_density_ms_8
* output/2_rc/2.4_rc_density_ms/rc_density_ms_9
* output/2_rc/2.4_rc_density_ms/rc_density_ms_10

_**2.5-dispersal-over-time-ss.R**_

READS:
* data/spatial/jdr_sections
* output/2_rc/2.1_rc_occupancy_ss/rc_occupancy_ss_1 TO output/2_rc/2.1_rc_occupancy_ss/rc_occupancy_ss_10

WRITES:
* output/2_rc/2.5_rc_dispersal_ss/rc_dispersal_ss_1
* output/2_rc/2.5_rc_dispersal_ss/rc_dispersal_ss_2
* output/2_rc/2.5_rc_dispersal_ss/rc_dispersal_ss_3
* output/2_rc/2.5_rc_dispersal_ss/rc_dispersal_ss_4
* output/2_rc/2.5_rc_dispersal_ss/rc_dispersal_ss_5
* output/2_rc/2.5_rc_dispersal_ss/rc_dispersal_ss_6
* output/2_rc/2.5_rc_dispersal_ss/rc_dispersal_ss_7
* output/2_rc/2.5_rc_dispersal_ss/rc_dispersal_ss_8
* output/2_rc/2.5_rc_dispersal_ss/rc_dispersal_ss_9
* output/2_rc/2.5_rc_dispersal_ss/rc_dispersal_ss_10

_**2.6-dispersal-over-time-ms.R**_

READS:
* output/2_rc/2.2_rc_occupancy_ms/rc_occupancy_ms_1 TO output/2_rc/2.2_rc_occupancy_ms/rc_occupancy_ms_10

WRITES:
* output/2_rc/2.6_rc_dispersal_ms/rc_dispersal_ms_1
* output/2_rc/2.6_rc_dispersal_ms/rc_dispersal_ms_2
* output/2_rc/2.6_rc_dispersal_ms/rc_dispersal_ms_3
* output/2_rc/2.6_rc_dispersal_ms/rc_dispersal_ms_4
* output/2_rc/2.6_rc_dispersal_ms/rc_dispersal_ms_5
* output/2_rc/2.6_rc_dispersal_ms/rc_dispersal_ms_6
* output/2_rc/2.6_rc_dispersal_ms/rc_dispersal_ms_7
* output/2_rc/2.6_rc_dispersal_ms/rc_dispersal_ms_8
* output/2_rc/2.6_rc_dispersal_ms/rc_dispersal_ms_9
* output/2_rc/2.6_rc_dispersal_ms/rc_dispersal_ms_10

_**2.7-abundance-replicates.R**_

READS:
* output/2_rc/2.1_rc_occupancy_ss/rc_occupancy_ss_1 TO output/2_rc/2.1_rc_occupancy_ss/rc_occupancy_ss_10
* output/2_rc/2.2_rc_occupancy_ms/rc_occupancy_ms_1 TO output/2_rc/2.2_rc_occupancy_ms/rc_occupancy_ms_10

WRITES:
* output/2_rc/3.4_replicates/rc_abundance_ss_s_reps
* output/2_rc/3.4_replicates/rc_abundance_ss_r_reps
* output/2_rc/3.4_replicates/rc_abundance_ms_s_reps
* output/2_rc/3.4_replicates/rc_abundance_ms_r_reps

_**2.8-occupancy-replicates.R**_

READS:
* output/2_rc/2.1_rc_occupancy_ss/rc_occupancy_ss_1 TO output/2_rc/2.1_rc_occupancy_ss/rc_occupancy_ss_10
* output/2_rc/2.2_rc_occupancy_ms/rc_occupancy_ms_1 TO output/2_rc/2.2_rc_occupancy_ms/rc_occupancy_ms_10

WRITES:
* output/2_rc/3.4_replicates/rc_occupancy_ss_reps
* output/2_rc/3.4_replicates/rc_occupancy_ms_reps

_**2.9-density-replicates.R**_

READS: 
* output/2_rc/2.3_rc_density_ss/rc_density_ss_1 TO output/2_rc/2.3_rc_density_ss/rc_density_ss_10
* output/2_rc/2.4_rc_density_ms/rc_density_ms_1 TO output/2_rc/2.4_rc_density_ms/rc_density_ms_10

WRITES:
* output/2_rc/3.4_replicates/rc_density_ss_reps
* output/2_rc/3.4_replicates/rc_density_ms_reps

**/3_comparison**

_**3.1-occupancy-comparison.R**_

READS:
* output/1_smb/3.4_replicates/smb_occupancy_ss_reps
* output/1_smb/3.4_replicates/smb_occupancy_ms_reps
* output/2_rc/3.4_replicates/rc_occupancy_ss_reps
* output/2_rc/3.4_replicates/rc_occupancy_ms_reps

WRITES: 
* output/3_both/3.1.1_smb_occupancy_basin.csv
* output/3_both/3.1.2_smb_occupancy_difference_basin.csv
* output/3_both/3.1.3_smb_occupancy_section.csv
* output/3_both/3.1.4_smb_occupancy_difference_section.csv
* output/3_both/3.1.5_rc_occupancy_basin.csv
* output/3_both/3.1.6_rc_occupancy_difference_basin.csv
* output/3_both/3.1.7_rc_occupancy_section.csv
* output/3_both/3.1.8_rc_occupancy_difference_section.csv

_**3.2-density-comparison.R**_

READS:
* output/1_smb/3.4_replicates/smb_density_ss_reps
* output/1_smb/3.4_replicates/smb_density_ms_reps
* output/2_rc/3.4_replicates/rc_density_ss_reps
* output/2_rc/3.4_replicates/rc_density_ms_reps

WRITES:
* output/3_both/3.2.1_smb_density_difference_basin
* output/3_both/3.2.2_smb_density_difference_section
* output/3_both/3.2.3_density_difference_basin
* output/3_both/3.2.4_density_difference_section

_**3.3-abundance-comparison.R**_

READS:
* output/1_smb/3.4_replicates/smb_abundance_ms_s_reps.csv
* output/1_smb/3.4_replicates/smb_abundance_ms_r_reps.csv
* output/2_rc/3.4_replicates/rc_abundance_ms_s_reps.csv
* output/2_rc/3.4_replicates/rc_abundance_ms_r_reps.csv

WRITES:
* 

**/4_figures**

_**4.1-occupancy-spatial-smb.R**_

READS:
* data/spatial/jdr_network/jdr_network
* output/1_smb/3.4_replicates/smb_occupancy_ss_reps

WRITES:
* output/4_figures/4.1-occupancy-spatial-smb/4.1.0-plot
* output/4_figures/4.1-occupancy-spatial-smb/4.1.1-plot
* output/4_figures/4.1-occupancy-spatial-smb/4.1.2-plot
* output/4_figures/4.1-occupancy-spatial-smb/4.1.3-plot
* output/4_figures/4.1-occupancy-spatial-smb/4.1.4-plot
* output/4_figures/4.1-occupancy-spatial-smb/4.1.5-plot

_**4.2-occupancy-trendline-smb.R**_

READS:
* data/spatial/jdr_sections
* output/3_both/3.1_smb_occupancy_basin
* output/3_both/3.2_smb_occupancy_difference_basin
* output/3_both/3.3_smb_occupancy_section
* output/3_both/3.4_smb_occupancy_difference_section

WRITES:
* output/4_figures/4.2-occupancy-trendline-smb/4.2.1-plot
* output/4_figures/4.2-occupancy-trendline-smb/4.2.2-plot
* output/4_figures/4.2-occupancy-trendline-smb/4.2.3-plot
* output/4_figures/4.2-occupancy-trendline-smb/4.2.4-plot

_**4.3-occupancy-spatial-rc.R**_

READS:
* data/spatial/jdr_network/jdr_network
* output/2_smb/3.4_replicates/rc_occupancy_ss_reps

WRITES:
* output/4_figures/4.3-occupancy-spatial-rc/4.3.0-plot
* output/4_figures/4.3-occupancy-spatial-rc/4.3.1-plot
* output/4_figures/4.3-occupancy-spatial-rc/4.3.2-plot
* output/4_figures/4.3-occupancy-spatial-rc/4.3.3-plot
* output/4_figures/4.3-occupancy-spatial-rc/4.3.4-plot
* output/4_figures/4.3-occupancy-spatial-rc/4.3.5-plot

_**4.4-occupancy-trendline-rc.R**_

READS:
* data/spatial/jdr_sections
* output/3_both/3.5_rc_occupancy_basin
* output/3_both/3.6_rc_occupancy_difference_basin
* output/3_both/3.7_rc_occupancy_section
* output/3_both/3.8_rc_occupancy_difference_section

WRITES:
* output/4_figures/4.4-occupancy-trendline-rc/4.4.1-plot
* output/4_figures/4.4-occupancy-trendline-rc/4.4.2-plot
* output/4_figures/4.4-occupancy-trendline-rc/4.4.3-plot
* output/4_figures/4.4-occupancy-trendline-rc/4.4.4-plot

_**4.5-occupancy-spatial-both.R**_

READS:
* data/spatial/jdr_network/jdr_network
* output/1_smb/3.4_replicates/smb_occupancy_ms_reps
* output/2_rc/3.4_replicates/rc_occupancy_ms_reps

WRITES:
* output/4_figures/4.5-occupancy-spatial-both/4.5.0-plot
* output/4_figures/4.5-occupancy-spatial-both/4.5.1-plot
* output/4_figures/4.5-occupancy-spatial-both/4.5.2-plot
* output/4_figures/4.5-occupancy-spatial-both/4.5.3-plot
* output/4_figures/4.5-occupancy-spatial-both/4.5.4-plot
* output/4_figures/4.5-occupancy-spatial-both/4.5.5-plot

_**4.6-abundance-smb.R**_

READS:
* output/1_smb/3.4_replicates/smb_abundance_ss_s_rep
* output/1_smb/3.4_replicates/smb_abundance_ms_s_reps.csv

WRITES:
* output/4_figures/4.6-abundance-smb/4.6.1-plot

_**4.7-abundance-rc.R**_

READS:
* output/2_rc/3.4_replicates/rc_abundance_ss_s_reps
* output/2_rc/3.4_replicates/rc_abundance_ms_s_reps

WRITES:
* output/4_figures/4.7-abundance-rc/4.7.1-plot

_**4.8-abundance-both.R**_

READS:
* output/1_smb/3.4_replicates/smb_abundance_ms_s_reps
* output/2_rc/3.4_replicates/rc_abundance_ms_s_reps

WRITES:
* output/4_figures/4.8-abundance-both/4.8.1-plot
