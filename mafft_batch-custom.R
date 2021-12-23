#!/netscrach/dep_psl/grp_psl/ThomasN/tools/bin/bin/Rscript
# R script for batch-processing Sanger sequencing restuls from Eurofins
# Associated with mafft_batch-custom.bash
# Ryohei Thomas Nakano, PhD; nakano@mpipz.mpg.de; 15 Dec 2021

library(ape)
library(stringr)

# read
dat_dir <- "/biodata/dep_psl/grp_psl/ThomasN/seq-results/"

ID       <- commandArgs(trailingOnly=T)[1]
output_dir <- paste(dat_dir, ID, "/results/", sep="")

# load data
dat_path <- paste(output_dir, ID, ".fasta", sep="")
fasta <- read.FASTA(dat_path)

map_path <- paste(dat_dir, ID, "/map.txt", sep="")
map <- read.table(map_path, header=F, sep="\t", col.names=c("results", "primer", "template"), stringsAsFactors=F, row.names=NULL)
map$results <- sapply(map$results, function(x) paste(x, x, sep="_"))

# sort
idx <- match(unique(map$results), names(fasta))
fasta <- fasta[idx]

write.FASTA(fasta, file=str_replace(dat_path, ".fasta", "-sorted.fasta"))


# filter out results to be skipped
idx <- map$template %in% c("", NA, "NA", "skip") | map$primer %in% c("", NA, "NA", "skip")
skip_ids <- map$results[idx]
map <- map[!idx,]

idx <- names(fasta) %in% skip_ids
fasta_skip <- fasta[idx]
fasta <- fasta[!idx]

write.FASTA(fasta_skip, file=str_replace(dat_path, ".fasta", "-skipped.fasta"))

# make fasta input files for mafft
for(x in unique(map$template)){
	temp_path <- paste(dat_dir, "template/", x, sep="")
	fasta_temp <- read.FASTA(temp_path)

	for(y in unique(map$primer[map$template==x])){
		idx <- match(map$results[map$template==x & map$primer==y], names(fasta))
		fasta_sub <- fasta[idx]

		fasta_out <- c(fasta_temp, fasta_sub)
		write.FASTA(fasta_out, file=paste(output_dir, str_replace(x, ".fasta", ""), "-", y, "temp.fasta", sep=""))
	}
}
