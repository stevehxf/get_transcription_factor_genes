# get_transcription_factor_genes
An R script for downloading transcription factor genes using the biomaRt package

## Downloading Transcription Factor Genes Using biomaRt
This  document describes an R script for downloading transcription factor genes using the biomaRt package. The script retrieves the Ensembl IDs and gene symbols of transcription factor genes in both the human and mouse genomes and exports the results to a CSV file.

### Required Packages
The script requires the following R packages to be installed:

`biomaRt`: This package provides an interface to access Ensembl data via the BioMart database.

`tidyverse`: This package provides a collection of packages for data manipulation and visualization in R.

### Connecting to the Ensembl BioMart
The first step in the script is to connect to the Ensembl BioMart using the `useMart()` function from the `biomaRt` package. This function requires the name of the Ensembl BioMart database to use, which in this case is `"ensembl"`.

`ensembl <- useMart("ensembl")`

### Selecting the Datasets
The script then selects the human and mouse datasets from the Ensembl BioMart using the `useDataset()` function from the `biomaRt` package. This function requires the name of the dataset to use and the `mart` object created in the previous step.

`human <- useDataset("hsapiens_gene_ensembl", mart = ensembl)`
`mouse <- useDataset("mmusculus_gene_ensembl", mart = ensembl)`

### Retrieving Transcription Factor Genes
The script uses the `getBM()` function from the `biomaRt` package to retrieve the Ensembl IDs and gene symbols of transcription factor genes in both the human and mouse genomes. This function requires the following arguments:

`attributes`: A vector of attribute names to retrieve.
`filters`: A filter or a vector of filters to apply to the query.
`values`: A value or a vector of values to match against the filters.
`mart`: The mart object created in the previous step.

Here's the code to retrieve the transcription factor genes for human:

`tf_go_id <- "GO:0003700"`
`human_tf_genes <- getBM(
  attributes = c("ensembl_gene_id", "external_gene_name"),
  filters = "go",
  values = tf_go_id,
  mart = human
)`

And here's the code to retrieve the transcription factor genes for mouse:

`mouse_tf_genes <- getBM(
  attributes = c("ensembl_gene_id", "external_gene_name"),
  filters = "go",
  values = tf_go_id,
  mart = mouse
)`

### Combining the Results
The script uses the `bind_rows()` function from the `tidyverse` package to combine the human and mouse transcription factor genes into one data frame. The `mutate()` function is used to add a new column called `species` to the data frame, which indicates the species of each gene.

`tf_genes <- bind_rows(human_tf_genes %>% mutate(species = "human"),
                      mouse_tf_genes %>% mutate(species = "mouse"))`
                      
### Exporting the Results
Finally, the script exports the transcription factor genes to a CSV file

