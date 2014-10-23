genotype_filter
===============
Filter vcf file by individuals' genotypes

First create genotype file as follows:
sample_name1:genotype1,genotype2
sample_name2:genotype1,genotype2
etc
See sample_genotypes.txt for example.

Usage example:
perl genotype_filter --file sample.vcf  --genotypes sample_genotypes.txt > sample.filtered.vcf

