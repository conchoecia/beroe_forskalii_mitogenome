#!/bin/bash

PREFIX=phylobayes_ctenos_allgenes_noguidance
# there are 5224 trees in chain 1. 5224/4 = 1306. Use 1306 for burn-in
BURNIN=1306

TC_loc=/usr/local/bin/temp/pbmpi/data/tracecomp
BPC_loc=/usr/local/bin/temp/pbmpi/data/bpcomp
${TC_loc} -x ${BURNIN} chain1 chain2 chain3 > ${PREFIX}.tracecomp_results
${BPC_loc} -x ${BURNIN} 10 chain1 chain2 chain3 > ${PREFIX}.bpcomp_results
mv bpcomp.con.tre  ${PREFIX}.con.tre
