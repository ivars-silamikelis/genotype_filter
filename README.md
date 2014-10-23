genotype_filter
===============
Filter vcf file by individuals' genotypes

First create genotype file as follows:\n
sample_name1:genotype1,genotype2\n
sample_name2:genotype1,genotype2\n
etc\n
See sample_genotypes.txt for example.\n

Usage example:
perl genotype_filter --file sample.vcf  --genotypes sample_genotypes.txt > sample.filtered.vcf

