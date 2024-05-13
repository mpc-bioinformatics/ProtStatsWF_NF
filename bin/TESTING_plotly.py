#!/usr/bin/env python3

import plotly
import pandas as pd
import argparse
import plotly.express as px

def argparse_setup():
    parser = argparse.ArgumentParser()
    parser.add_argument("-output_path", help="Output path", default=None)
    parser.add_argument("-D_validvalues_csv", help="Csv file with valid values.", default=None)
    parser.add_argument("-D_long_csv", help="Csv file with data set in long format.", default=None)
    parser.add_argument("-D_PCA_csv", help="Csv file with PCA data.", default=None)
    return parser.parse_args()


if __name__ == "__main__":
    args = argparse_setup()
    output_path = args.output_path
    D_validvalues_csv = args.D_validvalues_csv
    D_long_csv = args.D_long_csv
    D_PCA_csv = args.D_PCA_csv
    
    ### Barplots with valid values
    D_validvalues = pd.read_csv(D_validvalues_csv)
    fig_vv = px.bar(D_validvalues, x='name', y='nrvalid', color = 'group')
    fig_vv.update_layout(xaxis_title="Sample", yaxis_title="Number of valid values", legend={"title":"Group"})
    with open(output_path + "/validvalueplot.json", "w") as json_file:
        json_file.write(plotly.io.to_json(fig_vv))
    fig_vv.write_html(output_path + "/validvalueplot.html")
    
    
    #### Boxplots
    ### TODO: hovern sollte Proteinname anzeigen (fehlt in D-norm_long aber!)
    D_norm_long = pd.read_csv(D_long_csv)
    fig_box = px.box(D_norm_long, x="name", y="value", color = "group")
    fig_box.update_layout(xaxis_title="Sample", yaxis_title="log2(protein intensity)", legend={"title":"Group"}, boxgap = 0)
    with open(output_path + "/boxplots.json", "w") as json_file:
        json_file.write(plotly.io.to_json(fig_box))
    fig_box.write_html(output_path + "/boxplots.html")
        
    
    ### PCA
    ### TODO: x- und y-achse sollten % der erklärten Varianz anzeigen!
    ### TODO: Punkte in PCA etwas größer!
    D_PCA = pd.read_csv(D_PCA_csv)
    fig_pca = px.scatter(D_PCA, x="PCx", y="PCy", hover_data=['Sample'], color = 'groupvar1', custom_data = D_PCA)
    fig_pca.update_layout(xaxis_title="PC1", yaxis_title="PC2", legend={"title":"Group"})
    fig_pca.update_traces(hovertemplate='PC1: %{x} <br>PC2: %{y} <br>Sample: %{customdata[4]} <extra></extra>')
    with open(output_path + "/PCA.json", "w") as json_file:
        json_file.write(plotly.io.to_json(fig_pca))
    fig_pca.write_html(output_path + "/PCA.html")

    

