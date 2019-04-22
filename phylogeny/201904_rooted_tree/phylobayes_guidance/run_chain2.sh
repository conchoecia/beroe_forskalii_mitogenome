#!/bin/bash
pbmpiloc=/usr/local/bin/temp/pbmpi/data/pb_mpi
phylipfile=../../../fasta_sequences/alignments/concatenated_after_guidance/concatenated_prot.phy
threads=20
mpirun -np ${threads} ${pbmpiloc} -d ${phylipfile} chain2
