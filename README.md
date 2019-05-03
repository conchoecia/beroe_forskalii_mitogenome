[![DOI](https://zenodo.org/badge/112774670.svg)](https://zenodo.org/badge/latestdoi/112774670)

# beroe_forskalii_mitogenome

- This repository contains additional files for the manuscript, "Novel
  ORFs in the mitochondrial genome of the ctenophore, Beroe forskalii"
- The Additional Files section below is formatted for publication in a
  journal article.

## Abbreviations

- _Pb_ - _Pleurobrachia bachei_
- _Ml_ - _Mnemiopsis leidyi_
- _Bf_ - _Beroe forskalii_

## Additional Files

### Directory -- `16S_structure`

Files in this directory are related to determining the 16S structure
of the _B. forskalii_ mitochondrial genome. The files in this directory are:

- `mnemiopsis_rrnl_final.sto` is a structural Stockholm file. This encodes the _M. leidyi_ 16S rRNA structure from Pett et al 2011.
- `mnemi16S.cm` is the infernal covariance model built using `mnemiopsis_rrnl_final.sto`. 
- `Bf1311_against_mnemi16S.txt` is the infernal results file when the Bf1311 mitochondrial genome was searched against using the `mnemi16S.cm` covariance model.

### Directory -- `ARWEN`

This directory contains the fasta files of each _B. forskalii_ mitochondrial genome and the ARWEN results. The files in this directory are:

- `MG655622.fasta`- The Bf201706 mitochondrial genome.
- `MG655622_results.txt` - The Bf201706 ARWEN results.
- `MG655623.fasta` - The Bf201606 mitochondrial genome.
- `MG655623_results.txt` - The Bf201606 ARWEN results.
- `MG655624.fasta`- The Bf201311 mitochondrial genome.
- `MG655624_results.txt` - The Bf201311 ARWEN results.

### Directory -- `ATP6`

Files in this directory pertain to ATP6 of all ctenophores. This
directory contains:

- `README.md` contains notes about where to locate the _P. bachei_ and _M. leidyi_ ATP6 sequences.
- `PB_ML_ATP6_nucl.fasta` contains the _Pb_ and _Ml_ ATP6 transcript DNA sequences. 
- `PB_ML_ATP6_prot.fasta` contains the _Pb_ and _Ml_ ATP6 protein sequences.
- `ATP6_to_BF.txt` contains the tblastn results using the _Pb_ and _Ml_ ATP6 sequences to query the _Bf_ transcriptome
- `BF_ATP6_hits.fasta` contains the transcript sequences of the _Bf_ ATP6 blast hits.
- `BF_ATP6.fasta` contains the most likely _Bf_ ATP6 transcript based on protein sequence similarity to other ctenophore ATP6 sequences.
- `DS12*/DS12*_mapdepthavg.txt` contains the average map depth average when the DS121 and DS122 libraries were mapped against the _B. forskalii_ ATP6 transcript using `bwa mem`.

### Directory -- `Biosample_accessions`

Text files in this directory contain the NCBI BioSample Accession numbers
for all four _B. forskalii_ ctenophore individuals.

### Directory -- `CREx`

This directory contains the file, `crex_results_summary.pdf`, which
are the CREx mitochondrial rearrangement analysis results for the
_M. leidyi_, _B. forskalii_, and _P. bachei_ mitochondrial genomes.

### Directory -- `FTGwindow`

This directory contains files used in the Fourier Transform analysis to predict which regions of the mitochondrial genome contain protein-coding DNA.

### Directory -- `assembly`

This directory contains a single file, `bf_raw_mito.fa`, which is the raw mitochondrial genome assembly produced by canu.

### Directory -- `fasta_sequences`

This directory contains fasta files used in various analyses, including nucleotide and amino acid sequences, as well as various alignments. The files in this directory are

- Directory `BF201706_prot`
  - Directory `TM_results`
    - contains html file results from TMHMM for COX1, COX2, COX3, CYTB, ND1-6, URF1, and URF2.
  - Directory `TM_txtfiles`
    - Contains text files with transmembrane domain predictions by TMHMM. There are files for COX1, COX2, COX3, CYTB, ND1-6, URF1, and URF2.
  - file `Bf201706_prot.fasta` - the protein sequences from MG655622/Bf201706. These were used in generating the transmembrane domain prediction with TMHMM.
- Directory `alignments`
  - Directory `concatenated_after_guidance`
    - file `concatenated`
  - Directory `concatenated_noguidance`
  - Directory `ctenos_all_proteins_noguidance`
  - Directory `guidance_alignments`
  - Directory `nucl_alignment`
  - file `12S.fasta` - 12S alignment from _Pb_ and other ctenophores.
  - file `16S.fasta` - 16S alignment from _Bf_ and other ctenophores.
- Directory `coding_seqs`
- Directory `non-beroe`
- Directory `noncoding_seqs`
- Directory `test_seqs`
- file `bf_mitogenomes_alignment.fasta` - the whole-mitogenome _Bf_ alignment used to generate the table listing indels.

### Directory -- `figures`

### Directory -- `final_annotations`

Text files in this directory include the final DNA sequences of the
mitochondrial genomes of individuals Bf1311, Bf1706, and Bf1606. In
addition, we include the scripts `map_depth_extract.sh` and
`FastqPairedEndValidator.pl` used to isolate genomic reads that map to
the mitochondrial sequences.

### Directory -- `gff_files`

### Directory -- `indels`

### Directory -- `itasser_results`

Text and HTML files in this directory are from the ITASSER protein
structure prediction. Additionally there are structure files that can
be opened with protein viewing software.

### Directory - `phylogeny`

Text files in the directory `20170905_partition_finder` contain
results from a partition finder analysis of the mitochondrial
loci. The `20170906_rooted_tree` directory contains the phylip gene
matrix, RAxML partition files, and RAxML results. The command used to
generate these files are located in `20170906_rooted_tree/README.md`.

### Directory - `tRNAscanSE`
