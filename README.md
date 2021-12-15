# sanger_processing-eurofins

Usage: ./mafft_batch-custom.bash $ID  
where $ID is the ID for the project and can be any.  

input fasta file(s) need to be stored in the project directory under $dat_dir/$ID but no other fasta files. Multiple fasta files will be automatically concatenated.
template sequences need to be stored in $dat_dir/template.

map.txt should contain three tab-deliminated columns:
1. sequnce ID (EF1234567890). This will be automatically convered to the fasta headers (EF1234567890_EF1234567890)
2. primer names.
3. Template names to be aligned. The exact fasta files stored in $dat_dir/template


-----

Then run mafft_batch-custom.bash, and it does all.

-----

Required:  
- ape and stringr R packages
- mafft (https://mafft.cbrc.jp/alignment/software/)
