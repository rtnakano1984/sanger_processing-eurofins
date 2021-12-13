#!/netscrach/dep_psl/grp_psl/ThomasN/tools/bin/bin/Rscript

library(ape)
library(stringr)

# read
path <- commandArgs(trailingOnly=T)[1]
fasta <- read.FASTA(path)

# sort
idx <- order(names(fasta))
fasta <- fasta[idx]

# write
write.FASTA(fasta, str_replace(path, ".fasta", "-sorted.fasta"))

