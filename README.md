# Exercices Bioinformatique
## Exo 4

→ Notre point de départ : Fichier pedicularis2.vcf

Pour obtenir ce fichier, on a pris 3 séquences.fastq (site ncbi) qu’on a passé dans Ipyrad afin d’effectuer les 7 étapes paramétrées au préalable.

→ Création d'un fichier txt pour les loci
```
#Loci
grep 'RAD' ./pedicularis2.vcf | cut -f 3 >> loci.txt
```


→ Création d'un fichier txt pour le nombre d'allèles inter-individuel
```
#Allèles
grep 'RAD' ./pedicularis2.vcf | cut -f 5 >> var.txt
sed 's/,//g' var.txt | awk '{ print length +1 }' >> variants.txt
```

→ Création d'un fichier txt pour les individus = nombre d'allèles intra-individuel
```
#Individus 
grep 'RAD' ./pedicularis2.vcf | cut -f 10 | cut -d ':' -f 3 >> ind1.txt
sed 's,10,1,g' ind1.txt | sed 's,20,2,g'| sed 's,30,1,g' | sed 's/[^0]//g' | awk '{ print length -4 }' | cut -c 2 >> indiv1.txt
 
grep 'RAD' ./pedicularis2.vcf | cut -f 11 | cut -d ':' -f 3 >> ind2.txt
sed 's,10,1,g' ind2.txt | sed 's,20,2,g'| sed 's,30,1,g' | sed 's/[^0]//g' | awk '{ print length -4 }' | cut -c 2 >> indiv2.txt
 
grep 'RAD' ./pedicularis2.vcf | cut -f 12 | cut -d ':' -f 3 >> ind3.txt
sed 's,10,1,g' ind3.txt | sed 's,20,2,g'| sed 's,30,1,g' | sed 's/[^0]//g' | awk '{ print length -4 }' | cut -c 2 >> indiv3.txt
```

→ On colle tous les fichiers texte ensemble et on nomme les colonnes
```
paste loci.txt variants.txt indiv1.txt indiv2.txt indiv3.txt >>final.txt
(echo -e "  LOCUS ALLELES IND1 IND2 IND3"; cat final.txt ) >>final2.txt
```

→ On fait apparaître que les locus ayant une richesse génétique > 2
```
cut -f 3- final2.txt | grep '3' >> final3.txt 
```

On a donc 165 locus ayant une richesse génétique > 2 


## Exo 5
→ Notre point de départ : Fichier pedicularis.loci

→ Utilisation d'une boucle sur R pour convertir le fichier "pedicularis.loci" en ".fasta" et ajouter le numéro de loci à chaque séquence.
```
Rscript loci2fasta.R
```
Un fichier fasta est crée pour chaque loci

→ Regroupement de nos fichiers fasta en un seul
```
cat *.fasta >> all.fasta
```
Ce fichier contient les séquences de 3 individus.

→ Sélection du premier individu et création du fichier "all_filter.fasta" 
```
grep -A1 "SRR1754720$" all.fasta | grep -v "^--$" >> all_filter.fasta
```
→ Pour décompresser nos bases de données de référence pour les ITS, LSU et SSU
```
tar xvf ITS_eukaryote_sequences.tar
tar xvf LSU_eukaryote_rRNA.tar
tar xvf SSU_eukaryote_rRNA.tar
```

→ Combiner ces trois bases de données en une seule nommée "reference.all"
```
./blastdb_aliastool -dblist "ITS_eukaryote_sequences SSU_eukaryote_rRNA LSU_eukaryote_rRNA" -dbtype nucl -out reference.all -title "reference"
```

→ Utilisation de blastn pour visuliser les match entre les bases de données de réference et le fichier fasta contenant tous les loci de l'individu
```
./blastn -db reference.all -query all_filter.fasta -max_target_seqs 1 -out test.out -outfmt 6
```

Le fichier de sortie "test.out" met en evidence la présence d'un ITS /rDNA au locus n°11815.

En revenant au fichier "final2.text" généré au cours de l'exercice 4, on note que ce locus présente 2 allèles, ce qui n'est pas supérieur aux reste des loci.
