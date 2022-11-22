# Exercices Bioinformatique
## Exo 4

→ Notre point de départ : Fichier pedicularis.vcf
Pour obtenir ce fichier, on a pris 3 séquences.fastq (site ncbi) qu’on a passé dans Ipyrad afin d’effectuer les 7 étapes paramétrées au préalable.

→ Création d'un fichier txt pour les loci
```
#Loci
grep 'RAD' ./pedicularis2.vcf | cut -f 3 >> loci.txt
```


