#!/bin/bash

# parameters
ID=$1 # sequencing library (EUROFIN ID)

dat_dir="/biodata/dep_psl/grp_psl/ThomasN/seq-results"

# prepare input
files=$(ls ${dat_dir}/${ID}/*.fasta)

cat $files > ${ID}.fasta
/netscratch/dep_psl/grp_psl/ThomasN/tools/bin/bin/Rscript ${dat_dir}/sort_fasta.R ${dat_dir}/${ID}/${ID}.fasta

# prepare fasta files
/netscratch/dep_psl/grp_psl/ThomasN/tools/bin/bin/Rscript ${dat_dir}/mafft_batch-custom.R ${ID}

# mafft
files=$(ls ${dat_dir}/${ID}/*temp.fasta)

for f in ${files}; do
	mafft --adjustdirection --leavegappyregion --auto ${f} > ${f/temp.fasta/.fasta}
	rm ${f}
done

