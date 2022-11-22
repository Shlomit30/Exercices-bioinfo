# Exercices Bioinformatique
## Exo 4

→ Notre point de départ : Fichier pedicularis.vcf
Pour obtenir ce fichier, on a pris 3 séquences.fastq (site ncbi) qu’on a passé dans Ipyrad afin d’effectuer les 7 étapes paramétrées au préalable.

→ Création d'un fichier txt pour les loci
```
#Loci
grep 'RAD' ./pedicularis2.vcf | cut -f 3 >> loci.txt
```

→ Création d'un fichier txt pour le nombre d'allèle inter-individuel
```
#Allèles
grep 'RAD' ./pedicularis2.vcf | cut -f 5 >> var.txt
sed 's/,//g' var.txt | awk '{ print length +1 }' >> variants.tx
```

→ Création d'un fichier txt par individu (= séquence) pour le nombre d'allèle intra-individuel
```
#Individus 
grep 'RAD' ./pedicularis2.vcf | cut -f 10 | cut -d ':' -f 3 >> ind1.txt
sed 's,10,1,g' ind1.txt | sed 's,20,2,g'| sed 's,30,1,g' | sed 's/[^0]//g' | awk '{ print length -4 }' | cut -c 2 >> indiv1.txt
 
grep 'RAD' ./pedicularis2.vcf | cut -f 11 | cut -d ':' -f 3 >> ind2.txt
sed 's,10,1,g' ind2.txt | sed 's,20,2,g'| sed 's,30,1,g' | sed 's/[^0]//g' | awk '{ print length -4 }' | cut -c 2 >> indiv2.txt
 
grep 'RAD' ./pedicularis2.vcf | cut -f 12 | cut -d ':' -f 3 >> ind3.txt
sed 's,10,1,g' ind3.txt | sed 's,20,2,g'| sed 's,30,1,g' | sed 's/[^0]//g' | awk '{ print length -4 }' | cut -c 2 >> indiv3.txt

```






## Exo 5

Le fichier de sortie "test.out" met en evidence la présence d'un ITS /rDNA locus :  

Do these loci have, on average, more alleles than other loci?

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
