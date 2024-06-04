#!usr/bin/env nextflow
nextflow.enable.dsl=2

params.data_path = "/home/schorkka/Documents/ProtStatsWF_NF/testdata/HCC_19vs19.xlsx"
params.output_path = "."
params.intensity_columns = "10:47"
params.use_groups = "TRUE"


process Rscript {
  container 'workflow-r:latest'

  publishDir 'results', mode:'copy'

  input:
    val data_path
    val output_path
    val intensity_columns
    val use_groups

  output:
    file("D_norm_long.csv")
    file("D_norm_wide.csv")
    file("D_PCA.csv")
    file("D_validvalues.csv")
    path("*.pdf")

  """
  Rscript $baseDir/workflow_QC.R ${data_path} ${output_path} ${intensity_columns} ${use_groups}
  """ 
}


process Pythonscript {
  container 'workflow-python:latest'

  publishDir 'results', mode:'copy'
  
  input:
    val output_path
    file(D_validvalues_csv)
    file(D_long_csv)
    file(D_PCA_csv) 
    
  output:
    path("*.json")
    path("*.html")
    
  """
  workflow_QC_viz.py -output_path ${output_path} -D_validvalues_csv ${D_validvalues_csv} -D_long_csv ${D_long_csv} -D_PCA_csv ${D_PCA_csv}
  """ 
}


workflow {
  Rscript(params.data_path, params.output_path, params.intensity_columns, params.use_groups) 
  Pythonscript(params.output_path, Rscript.out[3], Rscript.out[0], Rscript.out[2])
} 