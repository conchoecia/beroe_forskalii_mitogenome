rule all:
    """
    The final files to be output at the end of this script.
    """
    input:
        #"figures/redwood/redwood.png",
        #"figures/codonusage/codonusage.png",
        #"figures/nucdiv/nucdiv.png",
        "figures/dirichlet_plot/dirichlet.png",
        #"figures/heterogeneity/hetero.png",
        #"figures/synteny/synteny.png"

rule plot_redwood:
    """
    Generates the redwood plot of the B. forskalii
    mitogenome.
    """
    input:
        pass
    output:
        pass
    shell:
        """
        pauvre redwood -M ./gd122_to_2013_doubled.bam \
          --doubled main \
          -R ./R007mergeASgt140.sorted.bam \
          --gff ../../gff_files/Bf201706.gff \
          --fileform pdf --sort ALNLEN \
          --query 'ALNLEN >= 10000' 'MAPLEN < reflength' \
          --small_start inside --ticks 0 10 100 1000
        """

#rule plot_codonusage:
#    """
#    Generates the codon usage plot.
#    """
#    input:
#        pass
#    output:
#        pass
#    shell:
#        pass

#rule plot_nucdiv:
#    """
#    Generates the nucleotide diversity plot.
#    """
#    input:
#        pass
#    output:
#        pass
#    shell:
#        pass

rule plot_dirichlet:
    """
    Generates the dirichlet LOO analysis plot for all genes.
    """
    input:
        COX1= "fasta_sequences/coding_seqs/COX1.fasta",
        COX2= "fasta_sequences/coding_seqs/COX2.fasta",
        COX3= "fasta_sequences/coding_seqs/COX3.fasta",
        CYTB= "fasta_sequences/coding_seqs/CYTB.fasta",
        ND1 = "fasta_sequences/coding_seqs/ND1.fasta",
        ND2 = "fasta_sequences/coding_seqs/ND2.fasta",
        ND3 = "fasta_sequences/coding_seqs/ND3.fasta",
        ND4 = "fasta_sequences/coding_seqs/ND4.fasta",
        ND4L = "fasta_sequences/coding_seqs/ND4L.fasta",
        ND5 = "fasta_sequences/coding_seqs/ND5.fasta",
        ND6 = "fasta_sequences/coding_seqs/ND6.fasta",
        nc1 = "fasta_sequences/noncoding_seqs/COX1to12S.fasta",
        nc2 = "fasta_sequences/noncoding_seqs/COX3toND3.fasta",
        nc3 = "fasta_sequences/noncoding_seqs/ND2LtoUNK.fasta",
        nc4 = "fasta_sequences/noncoding_seqs/ND2toCYTB.fasta",
        nc5 = "fasta_sequences/noncoding_seqs/ND5toND2L.fasta",
        nc6 = "fasta_sequences/noncoding_seqs/UNKtoND2.fasta",
        t1  = "fasta_sequences/test_seqs/ND2L.fasta",
        t2  = "fasta_sequences/test_seqs/UNK.fasta"
    output:
        fig = "figures/dirichlet_plot/dirichlet.png",
        results = "results/dirichlet_results.csv"
    params:
        obasename = "figures/dirichlet/dirichlet"
    shell:
        """
        cuttlery dirichlet \
        --coding_dir fasta_sequences/coding_seqs/ \
        --noncoding_dir fasta_sequences/noncoding_seqs/ \
        --test_dir fasta_sequences/test_seqs/ \
        --numsims 5000 \
        --results_file \
        {output.results} \
        -s meandec --fileform png \
        -o {params.obasename}
        """

#rule plot_hetero:
#    """
#    Generates the mutation heterogeneity plot.
#    """
#    input:
#        pass
#    output:
#        pass
#    shell:
#        pass

#rule plot_synteny:
#    """
#    Generates the synteny plot of all of the ctenophore mitochondrial genomes.
#    """
#    input:
#        pass
#    output:
#        pass
#    shell:
#        pass
