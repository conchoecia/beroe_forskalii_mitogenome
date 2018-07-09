rule all:
    """
    The final files to be output at the end of this script.
    """
    input:
        "figures/redwood/redwood.png",
        #"figures/codonusage/codonusage.png",
        "figures/dirichlet_plot/dirichlet_violins.png",
        "figures/heterogeneity_plot/hetero.pdf",
        "figures/heterogeneity_plot/hetero.csv",
        "figures/synteny_plot/synteny_optimum.pdf",
        "figures/nuc_div/nucdiv.csv",
        "figures/nuc_div/nuc_div_boxplot.png",
        "figures/nuc_div/nuc_div_picheck.png",
        "figures/codonusage/codonplot.pdf"


rule plot_synteny:
    """Generates the synteny plot of all of the ctenophore mitochondrial genomes.
    """
    input:
        twelveS = "fasta_sequences/alignments/12S.fasta",
        sixteenS = "fasta_sequences/alignments/16S.fasta",
        COX1 = "fasta_sequences/alignments/COX1.fasta",
        COX2 = "fasta_sequences/alignments/COX2.fasta",
        COX3 = "fasta_sequences/alignments/COX3.fasta",
        CYTB = "fasta_sequences/alignments/CYTB.fasta",
        ND1 = "fasta_sequences/alignments/ND1.fasta",
        ND2 = "fasta_sequences/alignments/ND2.fasta",
        ND3 = "fasta_sequences/alignments/ND3.fasta",
        ND4 = "fasta_sequences/alignments/ND4.fasta",
        ND4L = "fasta_sequences/alignments/ND4L.fasta",
        ND5 = "fasta_sequences/alignments/ND5.fasta",
        ND6 = "fasta_sequences/alignments/ND6.fasta",
        Cloyai = "gff_files/LN898113.gff",
        Bforsk = "gff_files/Bf201706.gff",
        Pbache = "gff_files/JN392469.gff",
        Mleidy = "gff_files/NC016117.gff",
        Cyulia = "gff_files/LN898114.gff",
        Vmulti = "gff_files/LN898115.gff",
    output:
        optimum = "figures/synteny_plot/synteny_optimum.pdf"
    params:
        basename = "figures/synteny_plot/synteny_optimum"
    shell:
        """
        pauvre synplot --aln_dir fasta_sequences/alignments/ \
          --fileform pdf \
          --gff_paths {input.Cloyai} {input.Bforsk} {input.Pbache} {input.Mleidy} {input.Cyulia} {input.Vmulti} \
          --gff_labels "C. loyai" "B. forskalii" "P. bachei" "M. leidyi" "C. yulianicorum" "V. multiformis" \
          --optimum_order --no_timestamp \
          -o {params.basename}
        """

rule plot_redwood:
    """
    Generates the redwood plot of the B. forskalii
    mitogenome.
    """
    input:
        longreads = "figures/redwood/gd122_to_2013_doubled.bam",
        RNA = "figures/redwood/R007mergeASgt140.sorted.bam",
        gff = "gff_files/Bf201706.gff"
    output:
        pngout = "figures/redwood/redwood.png",
    params:
        basename = "figures/redwood/redwood"
    shell:
        """
        pauvre redwood -M {input.longreads} \
          --doubled main -R {input.RNA} \
          --gff {input.gff} \
          --fileform png --sort ALNLEN \
          --query 'ALNLEN >= 10000' 'MAPLEN < reflength' \
          --dpi 600 --small_start inside \
          --ticks 0 10 100 1000 \
          -o {params.basename} --no_timestamp
        """

rule plot_codonusage:
    """
    Generates the codon usage plot.
    """
    input:
        COX1 = "fasta_sequences/coding_seqs/COX1.fasta",
        COX2 = "fasta_sequences/coding_seqs/COX2.fasta",
        COX3 = "fasta_sequences/coding_seqs/COX3.fasta",
        CYTB = "fasta_sequences/coding_seqs/CYTB.fasta",
        ND1 =  "fasta_sequences/coding_seqs/ND1.fasta",
        ND2 =  "fasta_sequences/coding_seqs/ND2.fasta",
        ND3 =  "fasta_sequences/coding_seqs/ND3.fasta",
        ND4 =  "fasta_sequences/coding_seqs/ND4.fasta",
        ND4L = "fasta_sequences/coding_seqs/ND4L.fasta",
        ND5 =  "fasta_sequences/coding_seqs/ND5.fasta",
        ND6 =  "fasta_sequences/coding_seqs/ND6.fasta"
    output:
        cu = "figures/codonusage/codonplot.pdf"
    params:
        basename = "figures/codonusage/codonplot"
    shell:
        """
        cuttlery codonplot \
          --coding_fasta_dir fasta_sequences/coding_seqs/
          --fileform pdf \
          --tt_code 4 \
          -o {params.basename} \
          --no_timestamp
        """

rule plot_nucdiv:
    """
    Generates the nucleotide diversity plot.
    """
    input:
        COX1 = "fasta_sequences/coding_seqs/COX1.fasta",
        COX2 = "fasta_sequences/coding_seqs/COX2.fasta",
        COX3 = "fasta_sequences/coding_seqs/COX3.fasta",
        CYTB = "fasta_sequences/coding_seqs/CYTB.fasta",
        ND1 =  "fasta_sequences/coding_seqs/ND1.fasta",
        ND2 =  "fasta_sequences/coding_seqs/ND2.fasta",
        ND3 =  "fasta_sequences/coding_seqs/ND3.fasta",
        ND4 =  "fasta_sequences/coding_seqs/ND4.fasta",
        ND4L = "fasta_sequences/coding_seqs/ND4L.fasta",
        ND5 =  "fasta_sequences/coding_seqs/ND5.fasta",
        ND6 =  "fasta_sequences/coding_seqs/ND6.fasta"
    output:
        csv = "figures/nuc_div/nucdiv.csv",
        bp = "figures/nuc_div/nuc_div_boxplot.png",
        pc = "figures/nuc_div/nuc_div_picheck.png"
    params:
        basename = "figures/nuc_div/nuc_div"
    shell:
        """
        cuttlery piNpiSsim \
          --tt_code 4 \
          --numsims 100 \
          --fasta_dir fasta_sequences/coding_seqs/ \
          --results_file {output.csv} \
          --method NG86 \
          -@ 4 \
          -o {params.basename} \
          --no_timestamp
        """

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
        fig = "figures/dirichlet_plot/dirichlet_violins.png",
        results = "results/dirichlet_results.csv"
    params:
        obasename = "figures/dirichlet_plot/dirichlet"
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
        --no_timestamp \
        -o {params.obasename}
        """

rule plot_hetero:
    """
    Generates the mutation heterogeneity plot.
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
        t1  = "fasta_sequences/test_seqs/ND2L.fasta",
        t2  = "fasta_sequences/test_seqs/UNK.fasta"
    output:
         "figures/heterogeneity_plot/hetero.pdf",
         "figures/heterogeneity_plot/hetero.csv",
    params:
        coding = "fasta_sequences/coding_seqs/",
        test = "fasta_sequences/test_seqs/",
        basename = "figures/heterogeneity_plot/hetero"
    shell:
        """
        cuttlery heterogeneity \
        --tt_code 4 \
        --fasta_dir {params.coding} {params.test} \
        --fileform pdf --no_timestamp -o {params.basename}
        """
