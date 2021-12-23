#!/netscrach/dep_psl/grp_psl/ThomasN/tools/bin/bin/Rscript

library(ape)
library(stringr)

# read
path <- commandArgs(trailingOnly=T)[1]
fasta <- read.FASTA(path)

# sort
names <- sort(unique(unlist(str_split(names(fasta), "_"))))

# write
write.table(names, file=str_replace(path, ".fasta", "-names.txt"), sep="\n", quote=F, col.names=F, row.names=F)

