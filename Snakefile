"""
This Snakefile runs the scripts to recreate the plots in
 Schultz et al 2018 (in prep).
"""

rule all:
    """
    The final files to be output at the end of this script.
    """
    input:
        "figures/redwood/redwood.png",
        "figures/dirichlet_plot/dirichlet_violins.png",
        "figures/heterogeneity_plot/hetero.pdf",
        "figures/heterogeneity_plot/hetero.csv",
        "figures/synteny_plot/synteny_optimum.pdf",
        "figures/nuc_div/nucdiv.csv",
        "figures/nuc_div/nuc_div_boxplot.png",
        "figures/nuc_div/nuc_div_picheck.png",
        "figures/codonusage/codonplot.pdf",
        #non-beroe
        "figures/dirichlet_plot_non_beroe/daphnia/daphnia_violins.png",
        "figures/dirichlet_plot_non_beroe/drosophila/drosophila_violins.png",
        "figures/dirichlet_plot_non_beroe/human/human_violins.png",
        "figures/dirichlet_plot_non_beroe/strongylocentrotus/strongylocentrotus_violins.png",
        "figures/dirichlet_plot_non_beroe/chlamydomonas/chlamydomonas_violins.png",


rule plot_synteny:
    """Generates the synteny plot of all of the ctenophore mitochondrial genomes.
    """
    input:
        twelveS =  "fasta_sequences/alignments/nucl_alignment/12S.fasta",
        sixteenS = "fasta_sequences/alignments/nucl_alignment/16S.fasta",
        COX1 =     "fasta_sequences/alignments/nucl_alignment/COX1.fasta",
        COX2 =     "fasta_sequences/alignments/nucl_alignment/COX2.fasta",
        COX3 =     "fasta_sequences/alignments/nucl_alignment/COX3.fasta",
        CYTB =     "fasta_sequences/alignments/nucl_alignment/CYTB.fasta",
        ND1 =      "fasta_sequences/alignments/nucl_alignment/ND1.fasta",
        ND2 =      "fasta_sequences/alignments/nucl_alignment/ND2.fasta",
        ND3 =      "fasta_sequences/alignments/nucl_alignment/ND3.fasta",
        ND4 =      "fasta_sequences/alignments/nucl_alignment/ND4.fasta",
        ND4L =     "fasta_sequences/alignments/nucl_alignment/ND4L.fasta",
        ND5 =      "fasta_sequences/alignments/nucl_alignment/ND5.fasta",
        ND6 =      "fasta_sequences/alignments/nucl_alignment/ND6.fasta",
        Cloyai =   "gff_files/LN898113.gff",
        Bforsk =   "gff_files/Bf201706.gff",
        Pbache =   "gff_files/JN392469.gff",
        Mleidy =   "gff_files/NC016117.gff",
        Cyulia =   "gff_files/LN898114.gff",
        Vmulti =   "gff_files/LN898115.gff",
    output:
        optimum = "figures/synteny_plot/synteny_optimum.pdf"
    params:
        basename = "figures/synteny_plot/synteny_optimum",
        alndir = "fasta_sequences/alignments/nucl_alignment/"
    shell:
        """
        pauvre synplot --aln_dir {params.alndir} \
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
        pngout = "figures/redwood/redwood.png"
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
          --coding_fasta_dir fasta_sequences/coding_seqs/ \
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
          --numsims 1000 \
          --fasta_dir fasta_sequences/coding_seqs/ fasta_sequences/test_seqs/ \
          --results_file {output.csv} \
          --method NG86 \
          -@ 4 \
          -o {params.basename} \
          --no_timestamp \
          --fileform png pdf jpg
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
        nc1 = "fasta_sequences/noncoding_seqs/COX1toND6.fasta",
        nc2 = "fasta_sequences/noncoding_seqs/COX3toND3.fasta",
        nc3 = "fasta_sequences/noncoding_seqs/URF1toURF2.fasta",
        nc4 = "fasta_sequences/noncoding_seqs/ND2toCYTB.fasta",
        nc5 = "fasta_sequences/noncoding_seqs/ND5toURF1.fasta",
        nc6 = "fasta_sequences/noncoding_seqs/URF2toND2.fasta",
        t1  = "fasta_sequences/test_seqs/URF1.fasta",
        t2  = "fasta_sequences/test_seqs/URF2.fasta"
    output:
        fig = "figures/dirichlet_plot/dirichlet_violins.png",
        results = "figures/dirichlet_plot/dirichlet_results.csv"
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
        -s meandec --fileform png pdf jpg \
        --no_timestamp \
        -o {params.obasename}
        """

rule plot_dirichlet_daphnia:
    """
    Generates the dirichlet LOO analysis plot for daphnia genes.
    """
    input:
        COX1= "fasta_sequences/non-beroe/daphnia/coding/COX1.fasta",
    output:
        fig = "figures/dirichlet_plot_non_beroe/daphnia/daphnia_violins.png",
        results = "figures/dirichlet_plot_non_beroe/daphnia/daphnia_results.csv"
    params:
        coding_dir = "fasta_sequences/non-beroe/daphnia/coding/",
        noncoding_dir = "fasta_sequences/non-beroe/daphnia/noncoding/",
        obasename = "figures/dirichlet_plot_non_beroe/daphnia"
    shell:
        """
        cuttlery dirichlet \
        --coding_dir {params.coding_dir} \
        --noncoding_dir {params.noncoding_dir} \
        --numsims 5000 \
        --results_file {output.results} \
        -s meandec --fileform png pdf jpg \
        --no_timestamp \
        -o {params.obasename}
        """

rule plot_dirichlet_strongylocentrotus:
    """
    Generates the dirichlet LOO analysis plot for strongylocentrotus genes.
    """
    input:
        COX1= "fasta_sequences/non-beroe/strongylocentrotus/coding/COX1.fasta",
    output:
        fig = "figures/dirichlet_plot_non_beroe/strongylocentrotus/strongylocentrotus_violins.png",
        results = "figures/dirichlet_plot_non_beroe/strongylocentrotus/strongylocentrotus_results.csv"
    params:
        coding_dir = "fasta_sequences/non-beroe/strongylocentrotus/coding/",
        noncoding_dir = "fasta_sequences/non-beroe/strongylocentrotus/noncoding/",
        obasename = "figures/dirichlet_plot_non_beroe/strongylocentrotus"
    shell:
        """
        cuttlery dirichlet \
        --coding_dir {params.coding_dir} \
        --noncoding_dir {params.noncoding_dir} \
        --numsims 5000 \
        --results_file {output.results} \
        -s meandec --fileform png pdf jpg \
        --no_timestamp \
        -o {params.obasename}
        """

rule plot_dirichlet_human:
    """
    Generates the dirichlet LOO analysis plot for human genes.
    """
    input:
        COX1= "fasta_sequences/non-beroe/human/coding/COX1.fasta",
    output:
        fig = "figures/dirichlet_plot_non_beroe/human/human_violins.png",
        results = "figures/dirichlet_plot_non_beroe/human/human_results.csv"
    params:
        coding_dir = "fasta_sequences/non-beroe/human/coding/",
        noncoding_dir = "fasta_sequences/non-beroe/human/noncoding/",
        obasename = "figures/dirichlet_plot_non_beroe/human"
    shell:
        """
        cuttlery dirichlet \
        --coding_dir {params.coding_dir} \
        --noncoding_dir {params.noncoding_dir} \
        --numsims 5000 \
        --results_file {output.results} \
        -s meandec --fileform png pdf jpg \
        --no_timestamp \
        -o {params.obasename}
        """

rule plot_dirichlet_drosophila:
    """
    Generates the dirichlet LOO analysis plot for drosophila genes.
    """
    input:
        COX1= "fasta_sequences/non-beroe/drosophila/coding/COX1.fasta",
    output:
        fig = "figures/dirichlet_plot_non_beroe/drosophila/drosophila_violins.png",
        results = "figures/dirichlet_plot_non_beroe/drosophila/drosophila_results.csv"
    params:
        coding_dir = "fasta_sequences/non-beroe/drosophila/coding/",
        noncoding_dir = "fasta_sequences/non-beroe/drosophila/noncoding/",
        obasename = "figures/dirichlet_plot_non_beroe/drosophila"
    shell:
        """
        cuttlery dirichlet \
        --coding_dir {params.coding_dir} \
        --noncoding_dir {params.noncoding_dir} \
        --numsims 5000 \
        --results_file {output.results} \
        -s meandec --fileform png pdf jpg \
        --no_timestamp \
        -o {params.obasename}
        """

rule plot_dirichlet_chlamydomonas:
    """
    Generates the dirichlet LOO analysis plot for chlamydomonas genes.
    """
    input:
        COX1= "fasta_sequences/non-beroe/chlamydomonas/coding/COX1.fasta",
    output:
        fig = "figures/dirichlet_plot_non_beroe/chlamydomonas/chlamydomonas_violins.png",
        results = "figures/dirichlet_plot_non_beroe/chlamydomonas/chlamydomonas_results.csv"
    params:
        coding_dir = "fasta_sequences/non-beroe/chlamydomonas/coding/",
        noncoding_dir = "fasta_sequences/non-beroe/chlamydomonas/noncoding/",
        obasename = "figures/dirichlet_plot_non_beroe/chlamydomonas"
    shell:
        """
        cuttlery dirichlet \
        --coding_dir {params.coding_dir} \
        --noncoding_dir {params.noncoding_dir} \
        --numsims 5000 \
        --results_file {output.results} \
        -s meandec --fileform png pdf jpg \
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
        t1  = "fasta_sequences/test_seqs/URF1.fasta",
        t2  = "fasta_sequences/test_seqs/URF2.fasta",
        COX1_TM = "fasta_sequences/BF201706_prot/TM_txtfiles/COX1_TM.txt",
        COX2_TM = "fasta_sequences/BF201706_prot/TM_txtfiles/COX2_TM.txt",
        COX3_TM = "fasta_sequences/BF201706_prot/TM_txtfiles/COX3_TM.txt",
        CYTB_TM = "fasta_sequences/BF201706_prot/TM_txtfiles/CYTB_TM.txt",
         ND1_TM = "fasta_sequences/BF201706_prot/TM_txtfiles/ND1_TM.txt",
         ND2_TM = "fasta_sequences/BF201706_prot/TM_txtfiles/ND2_TM.txt",
         ND3_TM = "fasta_sequences/BF201706_prot/TM_txtfiles/ND3_TM.txt",
         ND4_TM = "fasta_sequences/BF201706_prot/TM_txtfiles/ND4_TM.txt",
        ND4L_TM = "fasta_sequences/BF201706_prot/TM_txtfiles/ND4L_TM.txt",
         ND5_TM = "fasta_sequences/BF201706_prot/TM_txtfiles/ND5_TM.txt",
         ND6_TM = "fasta_sequences/BF201706_prot/TM_txtfiles/ND6_TM.txt",
          t1_TM = "fasta_sequences/BF201706_prot/TM_txtfiles/URF1_TM.txt",
          t2_TM = "fasta_sequences/BF201706_prot/TM_txtfiles/URF2_TM.txt",
    output:
         "figures/heterogeneity_plot/hetero.pdf",
         "figures/heterogeneity_plot/hetero.csv",
    params:
        coding = "fasta_sequences/coding_seqs/",
        test = "fasta_sequences/test_seqs/",
        basename = "figures/heterogeneity_plot/hetero",
        TM = "fasta_sequences/BF201706_prot/TM_txtfiles/"
    shell:
        """
        cuttlery heterogeneity \
        --tt_code 4 \
        --fasta_dir {params.coding} {params.test} \
        --TM_dir {params.TM} \
        --fileform pdf --no_timestamp -o {params.basename}
        """

#rule raxml:
#    input:
#        "phylogeny/20180609_rooted_tree/nuc_and_prot.phy",
#        "phylogeny/20180609_rooted_tree/partition.txt"
#    output:
#        "phylogeny/20180609_rooted_tree/RAxML_bipartitions.best"
#    params:
#        wd = "phylogeny/20180609_rooted_tree"
#    shell:
#        """
#        cd {params.wd};\
#        raxmlHPC-PTHREADS-SSE3 \
#          -m GTRGAMMA \
#          -p 12345 -x 12345 \
#          -f a -# autoMRE \
#          -o FUN_Imsh_alue_NC035550 \
#          -s nuc_and_prot.phy \
#          -q partition.txt
#          -n best -T 4; \
#        cd ../../
#        """
