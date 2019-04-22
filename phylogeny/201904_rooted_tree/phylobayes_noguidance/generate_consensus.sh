#!/bin/bash

PREFIX=phylobayes_noguidance
# there are 10243 trees in chain 1. 10243/4 = 2560. Use 2560 for burn-in
BURNIN=2560

TC_loc=/usr/local/bin/temp/pbmpi/data/tracecomp
BPC_loc=/usr/local/bin/temp/pbmpi/data/bpcomp
${TC_loc} -x ${BURNIN} chain1 chain2 chain3 > ${PREFIX}.tracecomp_results
${BPC_loc} -x ${BURNIN} 10 chain1 chain2 chain3 > ${PREFIX}.bpcomp_results
mv bpcomp.con.tre  ${PREFIX}.con.tre
