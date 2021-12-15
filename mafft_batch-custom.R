#!/netscrach/dep_psl/grp_psl/ThomasN/tools/bin/bin/Rscript

library(ape)
library(stringr)

# read
dat_dir <- "/biodata/dep_psl/grp_psl/ThomasN/seq-results/"

ID       <- commandArgs(trailingOnly=T)[1]
output_dir <- paste(dat_dir, ID, "/results/", sep="")

#
dat_path <- paste(output_dir, ID, "-sorted.fasta", sep="")
fasta <- read.FASTA(dat_path)

map_path <- paste(dat_dir, ID, "/map.txt", sep="")
map <- read.table(map_path, header=F, sep="\t", col.names=c("results", "primer", "template"), stringsAsFactors=F, row.names=NULL)
map$results <- sapply(map$results, function(x) paste(x, x, sep="_"))

#
for(x in unique(map$template)){
	temp_path <- paste(dat_dir, "template/", x, sep="")
	fasta_temp <- read.FASTA(temp_path)

	for(y in unique(map$primer[map$template==x])){
		idx <- names(fasta) %in% map$results[map$template==x & map$primer==y]
		fasta_sub <- fasta[idx]

		fasta_out <- c(fasta_temp, fasta_sub)
		write.FASTA(fasta_out, file=paste(output_dir, str_replace(x, ".fasta", ""), "-", y, "temp.fasta", sep=""))
	}
}
