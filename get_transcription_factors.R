# Load the required packages
library(biomaRt)
library(tidyverse)

# Connect to the Ensembl BioMart
ensembl <- useMart("ensembl")

# Select the human dataset
human <- useDataset("hsapiens_gene_ensembl", mart = ensembl)

# Select the mouse dataset
mouse <- useDataset("mmusculus_gene_ensembl", mart = ensembl)

# Define the GO term for transcription factors
tf_go_id <- "GO:0003700"

# Retrieve the transcription factor genes for human
human_tf_genes <- getBM(
  attributes = c("ensembl_gene_id", "external_gene_name"),
  filters = "go",
  values = tf_go_id,
  mart = human
)

# Retrieve the transcription factor genes for mouse
mouse_tf_genes <- getBM(
  attributes = c("ensembl_gene_id", "external_gene_name"),
  filters = "go",
  values = tf_go_id,
  mart = mouse
)

# Combine the human and mouse transcription factor genes into one data frame
tf_genes <- bind_rows(human_tf_genes %>% mutate(species = "human"),
                      mouse_tf_genes %>% mutate(species = "mouse"))

# Export the result as a csv file
write_csv(tf_genes, "transcription_factor_genes.csv")
