#!/bin/bash

for i in {1..22}

do

awk '{print $2}' /sc/orga/projects/COGA/Data/COGA_gwas/Imputed/ReImputed_April_2015/Cleaned/chr${i}_imputed_April2015.bim | \
awk -v chromo=$i 'BEGIN{c=1}{print > "coga.ea.split.chr" chromo ".file." c ".csv"}!(NR % 5000){c++}' 

done