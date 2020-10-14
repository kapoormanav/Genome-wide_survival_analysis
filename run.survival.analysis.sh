#!/bin/bash

for i in {4..22}

do

for file in ` echo coga.ea.split.chr$i.file*csv | sed 's/.csv//g'`

do

cat <<EOF > $file.lsf

#!/bin/bash
#BSUB -J coga
#BSUB -P acc_COGA
#BSUB -q premium
#BSUB -n 1
#BSUB -R "rusage[mem=8000]"
#BSUB -W 00:10
#BSUB -o %J.stdout
#BSUB -eo %J.stderr
#BSUB -L /bin/bash

cd /sc/orga/scratch/kapoom02/age_onset_alcohol/split_files/output_files/
module load R
R CMD /hpc/users/kapoom02/.Rlib/Rserve/libs//Rserve --no-save
module load plink
plink --bfile /sc/orga/projects/COGA/Data/COGA_gwas/Imputed/ReImputed_April_2015/Cleaned/chr${i}_imputed_April2015 \
        --pheno /sc/orga/scratch/kapoom02/age_onset_alcohol/coga_all_sample_pcs.fid.V2.txt \
        --covar /sc/orga/scratch/kapoom02/age_onset_alcohol/coga_all_sample_pcs.fid.V2.txt \
        --R /sc/orga/scratch/kapoom02/age_onset_alcohol/survival_analysis.R \
        --maf 0.01 \
        --extract /sc/orga/scratch/kapoom02/age_onset_alcohol/split_files/$file.csv \
        --pheno-name aao_ad \
        --covar-name reg_AD,sex,cohort2,cohort3,cohort4,fam_id \
        --hide-covar \
        --out /sc/orga/scratch/kapoom02/age_onset_alcohol/split_files/output_files/survival_analysis.$file

EOF

        
        
        bsub <$file.lsf

done

sleep 10
        
        done