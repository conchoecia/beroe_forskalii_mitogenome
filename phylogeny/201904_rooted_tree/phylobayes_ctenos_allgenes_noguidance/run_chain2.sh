#!/bin/bash
pbmpiloc=/usr/local/bin/temp/pbmpi/data/pb_mpi
phylipfile=../../../fasta_sequences/alignments/ctenos_all_proteins_noguidance/all_proteins_ctenos_monoallo_noguidance.phy
threads=20
mpirun -np ${threads} ${pbmpiloc} -d ${phylipfile} chain2
