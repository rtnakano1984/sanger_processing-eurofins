#!/bin/bash

ID=$1
dat_dir="/biodata/dep_psl/grp_psl/ThomasN/seq-results"

files=$(ls ${dat_dir}/${ID}/*.fasta)

for f in ${files}; do
	mafft --adjustdirection --leavegappyregion --auto ${f} > ${f/.fasta/-mafft.fasta}
done
