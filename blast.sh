#!/bin/bash

#Lancer r
Rscript loci2fasta.R

#regrouper nos fichiers fasta en 1 fasta 
cat *.fasta >> all.fasta

#Deziper nos databases de référence
tar xvf ITS_eukaryote_sequences.tar
tar xvf LSU_eukaryote_rRNA.tar
tar xvf SSU_eukaryote_rRNA.tar

#On combine ces trois BDD en une
./blastdb_aliastool -dblist "ITS_eukaryote_sequences SSU_eukaryote_rRNA LSU_eukaryote_rRNA" -dbtype nucl -out reference.all -title "reference"


#On sélectionne un seul individu 
grep -A1 "SRR1754720$" all.fasta | grep -v "^--$" >> all_filter.fasta

#On utilise blastn pour voir les match
./blastn -db reference.all -query all_filter.fasta -max_target_seqs 1 -out test.out -outfmt 6

echo ('test.out')
