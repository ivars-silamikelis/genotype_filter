#!/usr/bin/perl;
use strict;
use warnings;
use Getopt::Long;
use Data::Dumper;
use List::Util qw(first);
my %opts;
GetOptions(\%opts, "file=s", "genotypes=s" );
unless (keys %opts){
	print "Usage:\nperl genotype_filter --file <FILE> --genotypes <FILE>";
}
my %genotypes;
my @vcf_header;
open my $vcfh, "<", $opts{"file"} or die "specify vcf file\n";
open my $genfh, "<", $opts{"genotypes"} or die "specify genotype file\n";
#Process genotype file
while(<$genfh>){
	chomp($_);
	$_=~s/ //g;
	my @fields = split(":",$_);
	@{$genotypes{$fields[0]}} = split(",",$fields[1]);
}
my $sample_count=scalar (keys %genotypes);
#Process vcf file
close $genfh;
my %sample_indexes;
while (<$vcfh>){
	my $genotype_matches=0;
	chomp($_);
	if ($_=~/CHROM\tPOS/){
		my @header = split("\t",$_);
		#get sample indexes to know which genotype belongs to which sample
		for my $sample (keys %genotypes){
			$sample_indexes{$sample} = first {$header[$_] eq $sample} 0..$#header;
		}
	}
	if ($_=~/^#/){
		print $_,"\n";
		next;
	} else {
		my @fields = split("\t",$_);
		for my $sample (keys %genotypes){
			#split data about sample in vcf file
			my @data = split(":",$fields[$sample_indexes{$sample}]);
			if (grep {$_ eq $data[0]} (@{$genotypes{$sample}})){
				++$genotype_matches;
			}
		}
		print $_,"\n" if $genotype_matches == $sample_count;
	}
	
}
close $vcfh;
print $sample_count,"\n";
#print Dumper (\%sample_indexes);
