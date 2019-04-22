#!/bin/bash
pbmpiloc=/usr/local/bin/temp/pbmpi/data/pb_mpi
phylipfile=../../../fasta_sequences/alignments/concatenated_noguidance/concatenated_noguidance.phy
threads=20
mpirun -np ${threads} ${pbmpiloc} -d ${phylipfile} chain3
