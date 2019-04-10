#!/bin/bash
guidance_path=YOUR_PATH_TO_guidance.pl_HERE
seqs_path=./seqs
threads=1
echo "guidance path is ${guidance_path}"
for file in ${seqs_path}/*.fasta;
do
   dirname=`echo ${file} | sed 's/.fasta//g' | awk -F '/' '{print($NF)}'`
   outpath="${PWD}/${dirname}"
   echo "- file is ${file}"
   echo "  - putting data into ${outpath}"
   if [ -d ${dirname} ]; then rm -Rf ${dirname}; fi
   mkdir ${dirname}
   perl ${guidance_path} --seqFile ${file} --msaProgram MAFFT --seqType aa --outDir ${outpath} --proc_num ${threads}
done

