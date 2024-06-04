
#!/usr/bin/env Rscript

# first install packages affy, matrixStats and vsn
#install.packages("../ProtStatsWF", repos = NULL, type="source")
library(limma)
library(ProtStatsWF)

# library(openxlsx)
# D <- read.xlsx("..\\testdata/01_QC/HCC_19vs19.xlsx")

args <- commandArgs(TRUE)

# data_path = "testdata/HCC_19vs19.xlsx"
# intensity_columns = 10:47
# output_path = "example_output/"
# use_groups = TRUE

data_path = args[1]
output_path = args[2]
intensity_columns = eval(parse(text=args[3]))
use_groups = as.logical(args[4])


### weitere Parameter für die User:
# group_colours

### hashtag if we need this in the command line

workflow_QC(data_path = data_path, #
            intensity_columns = intensity_columns, #
            output_path = output_path, #

            na_strings = c("NA", "NaN", "Filtered","#NV"),
            zero_to_NA = TRUE, #

            do_log_transformation = TRUE, #
            log_base = 2, #

            use_groups = use_groups, #
            groupvar_name = "Group",
            group_colours = NULL,

            base_size = 15,
            plot_device = "pdf",
            plot_height = 10,
            plot_width = 15,
            plot_dpi = 300,
            suffix = "",

            normalization_method = "loess", #

            boxplot_method = "boxplot",

            MA_maxPlots = 5000,
            MA_alpha = FALSE,

            #PCA_groupvar1 = NULL,
            #PCA_groupvar2 = NULL,
            PCA_impute = FALSE, PCA_impute_method = "mean", PCA_propNA = 0,
            PCA_scale. = TRUE,
            PCA_PCx = 1, PCA_PCy = 2,
            PCA_groupvar1_name = "Group",
            #PCA_groupvar2_name = NULL,
            PCA_alpha = 1, PCA_label = FALSE, PCA_label_seed = NA, PCA_label_size = 4,
            PCA_xlim = NULL, PCA_ylim = NULL, PCA_point.size = 4
            )
