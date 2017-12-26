[![DOI](https://zenodo.org/badge/112774670.svg)](https://zenodo.org/badge/latestdoi/112774670)

# beroe_forskalii_mitogenome

- This repository contains additional files for the manuscript, "Novel
  ORFs in the mitochondrial genome of the ctenophore, Beroe forskalii"
- The Additional Files section below is formatted for publication in a
  journal article.

## Additional Files

### Additional file 1 -- 16S_structure

Files in this directory are related to determining the 16S structure
of the _B. forskalii_ mitochondrial genome. Contains: 1)
`mnemiopsis_rrnl_final.sto` which is a structural Stockholm file. This
encodes the _M. leidyi_ 16S rRNA structure from Pett et al 2011. 2)
`mnemi16S.cm` is the infernal covariance model built using
`mnemiopsis_rrnl_final.sto`. 3) `Bf1311_against_mnemi16S.txt` is the
infernal results file when the Bf1311 mitochondrial genome was
searched against using the `mnemi16S.cm` covariance model. All of
these files can be opened using a text editor.

### Additional file 2 -- ATP6

Files in this directory pertain to ATP6 of all ctenophores. This
directory contains: 1) `README.md` contains notes about where to
locate the _P. bachei_ and _M. leidyi_ ATP6 sequences. 2)
`PB_ML_ATP6_nucl.fasta` contains the _Pb_ and _Ml_ ATP6 transcript DNA
sequences. 3) `PB_ML_ATP6_prot.fasta` contains the PB and ML ATP6
protein sequences. 4) `ATP6_to_BF.txt` contains the tblastn results
using the _Pb_ and _Ml_ ATP6 sequences to query the _Bf_ transcriptome
5) `BF_ATP6_hits.fasta` contains the transcript sequences of the _Bf_
ATP6 blast hits. 6) `BF_ATP6.fasta` contains the most likely _Bf_ ATP6
transcript based on protein sequence similarity to other ctenophore
ATP6 sequences.  7) `DS12*/DS12*_mapdepthavg.txt` contains the average
map depth average when the DS121 and DS122 libraries were mapped
against the _B. forskalii_ ATP6 transcript using `bwa mem`. These
files can all be opened with a text editor.

### Additional file 3 -- Biosample_accessions

Text files in this directory contain the NCBI BioSample Accession numbers
for all four _B. forskalii_ ctenophore individuals.

### Additional file 4 -- CREx

This directory contains the file, `crex_results_summary.pdf`, which
are the CREx mitochondrial rearrangement analysis results for the
_M. leidyi_, _B. forskalii_, and _P. bachei_ mitochondrial genomes.

### Additional file 5 -- final_annotations

Text files in this directory include the final DNA sequences of the
mitochondrial genomes of individuals Bf1311, Bf1706, and Bf1606. In
addition, we include the scripts `map_depth_extract.sh` and
`FastqPairedEndValidator.pl` used to isolate genomic reads that map to
the mitochondrial sequences.

### Additional file 6 -- itasser_results

Text and HTML files in this directory are from the ITASSER protein
structure prediction. Additionally there are structure files that can
be opened with protein viewing software.

### Additional file 7 - phylogeny

Text files in the directory `20170905_partition_finder` contain
results from a partition finder analysis of the mitochondrial
loci. The `20170906_rooted_tree` directory contains the phylip gene
matrix, RAxML partition files, and RAxML results. The command used to
generate these files are located in `20170906_rooted_tree/README.md`.
