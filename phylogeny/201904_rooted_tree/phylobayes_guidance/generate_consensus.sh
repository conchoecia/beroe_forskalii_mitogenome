#!/bin/bash

PREFIX=phylobayes_guidance
# there are 34581 trees in chain 1. 34581/4 = 8645. Use 8645 for burn-in
BURNIN=8645

TC_loc=/usr/local/bin/temp/pbmpi/data/tracecomp
BPC_loc=/usr/local/bin/temp/pbmpi/data/bpcomp
${TC_loc} -x ${BURNIN} chain1 chain2 chain3 > ${PREFIX}.tracecomp_results
${BPC_loc} -x ${BURNIN} 10 chain1 chain2 chain3 > ${PREFIX}.bpcomp_results
mv bpcomp.con.tre  ${PREFIX}.con.tre
