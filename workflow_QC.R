
#!/usr/bin/env Rscript

# first install packages affy, matrixStats and vsn
#install.packages("../ProtStatsWF", repos = NULL, type="source")
library(limma)
library(ProtStatsWF)
library(optparse)

option_list <- list( 
  make_option(opt_str = c("--data_path"), 
              type = "character",
              help = "A string of the input path for the data."),
  make_option(opt_str = c("--output_path"), 
              type = "character",
              help = "A string of the input path for the data."),
  make_option(opt_str = c("--intensity_columns_start"), 
              type = "integer",
              help = "An integer of the first data column."),
  make_option(opt_str = c("--intensity_columns_end"), 
              type = "integer",
              help = "An integer of the last data column."),
  make_option(opt_str = c("--use_groups"), 
              type = "logical",
              default = "TRUE",
              help = "A logical if groupings should be used."),
  make_option(opt_str = c("--zero_to_NA"), 
              type = "logical",
              default = "TRUE",
              help = "A logical if 0 should be considered 0 or turned into not-available/NA."),
  make_option(opt_str = c("--do_log_transformation"), 
              type = "logical",
              default = "TRUE",
              help = "A logical if the data should be log transformed."),
  make_option(opt_str = c("--log_base"), 
              type = "integer",
              default = 2,
              help = "An integer base the data should be log transformed in, if it is going to be log transformed."),
  make_option(opt_str = c("--normalization_method"), 
              type = "character",
              default = "loess",
              help = "A character of the normalization method. Possible methods are no normalization nonorm or median, loess (default), quantile or lts normalization"),
  make_option(opt_str = c("--PCA_impute"), 
              type = "logical",
              default = "FALSE",
              help = "A logical if the data should imputed when doing the PCA."),
  make_option(opt_str = c("--PCA_impute_method"), 
              type = "character",
              default = "mean",
              help = "A character containing the method the data for the PCA is imputed. Methods are mean (default) or median")
)

opt <- parse_args(OptionParser(option_list=option_list))

if(is.null(opt$data_path)){
  message("The data path is missing. Add: --data_path <your/data/path/file.xlsx>")
}
if(is.null(opt$output_path)){
  message("The output path is missing. Add: --output_path <your/output/path/folder>")
}
if(is.null(opt$intensity_columns_start)){
  message("The column number where the data starts is missing. Add: --intensity_columns_start <number>")
}
if(is.null(opt$intensity_columns_end)){
  message("The column number where the data ends is missing. Add: --intensity_columns_end <number>")
}


intensity_columns = opt$intensity_columns_start:opt$intensity_columns_end


print(getwd())

### weitere Parameter für die User:
# group_colours

### hashtag if we need this in the command line

workflow_QC(data_path = opt$data_path,
            intensity_columns = intensity_columns,
            output_path = opt$output_path,
            
            na_strings = c("NA", "NaN", "Filtered","#NV"),
            zero_to_NA = opt$zero_to_NA,
            
            do_log_transformation = opt$do_log_transformation,
            log_base = opt$log_base,
            
            use_groups = opt$use_groups,
            groupvar_name = "Group",
            group_colours = NULL,
            
            base_size = 15,
            plot_device = "pdf",
            plot_height = 10,
            plot_width = 15,
            plot_dpi = 300,
            suffix = "",
            
            normalization_method = opt$normalization_method,
            
            boxplot_method = "boxplot",
            
            MA_maxPlots = 5000,
            MA_alpha = FALSE,
            
            #PCA_groupvar1 = NULL,
            #PCA_groupvar2 = NULL,
            PCA_impute = opt$PCA_impute, PCA_impute_method = opt$PCA_impute_method, PCA_propNA = 0,
            PCA_scale. = TRUE,
            PCA_PCx = 1, PCA_PCy = 2,
            PCA_groupvar1_name = "Group",
            #PCA_groupvar2_name = NULL,
            PCA_alpha = 1, PCA_label = FALSE, PCA_label_seed = NA, PCA_label_size = 4,
            PCA_xlim = NULL, PCA_ylim = NULL, PCA_point.size = 4
            )
