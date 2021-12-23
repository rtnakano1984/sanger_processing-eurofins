# sanger_processing-eurofins

Usage: `./mafft_batch-custom.bash $ID`  
where $ID is the ID for the project and can be any.  

input fasta file(s) need to be stored in the project directory under $dat_dir/$ID but no other fasta files. Multiple fasta files will be automatically concatenated.
template sequences need to be stored in $dat_dir/template.

map.txt should contain three tab-deliminated columns:
1. sequnce ID (EF1234567890). This will be automatically convered to the fasta headers (EF1234567890_EF1234567890)
2. primer names.
3. Template names to be aligned. The exact fasta files stored in $dat_dir/template
4. If either primer or template is missing for a row, this data will be skipped from the analysis and exported into \*-skpped.fasta

-----

Then run mafft_batch-custom.bash, and it does all.

Followings are accessories scripts that are not directly included in the main script.  
- sort_fasta.R alphabetically sorts entiries according to the sequence headers.
  - `Rscript sort_fasta.R [input.fasta]` returns input-sorted.fasta at the same location as the input file.
- fasta-id_extract.R extracts header names into a text file
  - `Rscript fasta-id_extract.R [input.fasta]` returns a text file containing the fasta seq headers at the same location as the input file.

-----

Required:  
- ape and stringr R packages
- mafft (https://mafft.cbrc.jp/alignment/software/)
