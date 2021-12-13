#!/bin/bash

# bash script for batch-processing Sanger sequencing restuls from Eurofins

# common parameters
set -e
set -o nounset
dat_dir="/biodata/dep_psl/grp_psl/ThomasN/seq-results"

# parameters
ID=$1 # sequencing library (EUROFIN ID)

input_file="${dat_dir}/${ID}/${ID}.fasta"
log="${dat_dir}/${ID}/output.text"

rm -rf ${log}

# prepare input
count=$(ls ${dat_dir}/${ID}/*.fasta | wc -l)

if [ "$count" -lt 1 ]; then
	echo "No fasta file detected."
	exit 1
elif [ "$count" -eq 1 ]; then
	[ ! -f ${input_file} ] && mv ${dat_dir}/${ID}/*.fasta ${input_file}
else
	cat ${dat_dir}/${ID}/*.fasta > ${input_file}
fi

# sort
/netscratch/dep_psl/grp_psl/ThomasN/tools/bin/bin/Rscript ${dat_dir}/sort_fasta.R ${input_file}

# prepare fasta files
/netscratch/dep_psl/grp_psl/ThomasN/tools/bin/bin/Rscript ${dat_dir}/mafft_batch-custom.R ${ID}

# mafft alignment
files=$(ls ${dat_dir}/${ID}/*temp.fasta)
for f in ${files}; do
	mafft --adjustdirection --leavegappyregion --auto ${f} > ${f/temp.fasta/.fasta} &>> ${log}
	rm ${f}
done

