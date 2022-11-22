#!/bin/bash

#Loci
grep 'RAD' ./pedicularis2.vcf | cut -f 3 >> loci.txt

#Allèles
grep 'RAD' ./pedicularis2.vcf | cut -f 5 >> var.txt
sed 's/,//g' var.txt | awk '{ print length +1 }' >> variants.txt


#Individus 
grep 'RAD' ./pedicularis2.vcf | cut -f 10 | cut -d ':' -f 3 >> ind1.txt
sed 's,10,1,g' ind1.txt | sed 's,20,2,g'| sed 's,30,1,g' | sed 's/[^0]//g' | awk '{ print length -4 }' | cut -c 2 >> indiv1.txt
 
grep 'RAD' ./pedicularis2.vcf | cut -f 11 | cut -d ':' -f 3 >> ind2.txt
sed 's,10,1,g' ind2.txt | sed 's,20,2,g'| sed 's,30,1,g' | sed 's/[^0]//g' | awk '{ print length -4 }' | cut -c 2 >> indiv2.txt
 
grep 'RAD' ./pedicularis2.vcf | cut -f 12 | cut -d ':' -f 3 >> ind3.txt
sed 's,10,1,g' ind3.txt | sed 's,20,2,g'| sed 's,30,1,g' | sed 's/[^0]//g' | awk '{ print length -4 }' | cut -c 2 >> indiv3.txt
 

paste loci.txt variants.txt indiv1.txt indiv2.txt indiv3.txt >>final.txt
(echo -e "  LOCUS ALLELES IND1 IND2 IND3"; cat final.txt ) >>final2.txt

#Chercher que les allèles tri-alléliques
cut -f 3- final2.txt | grep '3' >> final3.txt 


