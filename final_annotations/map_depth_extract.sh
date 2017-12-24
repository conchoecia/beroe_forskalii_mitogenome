#!/bin/bash
# Use -gt 1 to consume two arguments per pass in the loop (e.g. each
# argument has a corresponding value to go with it).
# Use -gt 0 to consume one or more arguments per pass in the loop (e.g.
# some arguments don't have a corresponding value to go with it such
# as in the --default example).
# note: if this is set to -gt 0 the /etc/hosts part is not recognized ( may be a bug )
while [[ $# -gt 1 ]]
do
key="$1"

case $key in
    -f|--forward)
    FORWARD="$2"
    shift # past argument
    ;;
    -r|--reverse)
    REVERSE="$2"
    shift # past argument
    ;;
    -s|--scaffold)
    SCAFFOLD="$2"
    shift # past argument
    ;;
    -@|--threads)
    THREADS="$2"
    shift # past argument
    ;;
    -l|--libname)
    LIBNAME="$2"
    shift # past argument
    ;;
    *)
    # unknown option
    ;;
esac
shift # past argument or value
done

echo forward = "$FORWARD"
echo reverse = "$REVERSE"
echo scaffold = "$SCAFFOLD"
echo LIBNAME = "$LIBNAME"
echo threads = "$THREADS"

if [ "$FORWARD" == "$REVERSE" ]; then
  echo "ERROR: The forward and reverse file paths are the same. This must be an error. Try again please." 1>&2
  exit 1 # terminate and indicate error
fi

# if we have not yet made the bam file, make it
if ! [ -f "$LIBNAME".sorted.bam ]; then
    echo "Processing reads"
    bwa index "$SCAFFOLD"
    bwa mem -t "$THREADS" "$SCAFFOLD" "$FORWARD" "$REVERSE" | samtools view -h -F 4 -@ "$THREADS" - | samtools sort -@ "$THREADS" - > "$LIBNAME".sorted.bam
    samtools index "$LIBNAME".sorted.bam
else
    echo "There is already a bam file (${LIBNAME}.sorted.bam). Skipping the bwa mem mapping step."
fi

# same for fastq files, make them if they don't exist
if ! [ -f "$LIBNAME"_mito_1.fq.gz ]; then
    # this bit makes the fastq files
    echo "Trying to delete any fastq files here. Ignore error messages, 'rm: cannot remove...'"
    rm "$LIBNAME"_mito_1.fq* "$LIBNAME"_mito_2.fq*
    rm "$LIBNAME"_uniq_ids.txt
    samtools view "$LIBNAME".sorted.bam | cut -f1 | sort | uniq > "$LIBNAME"_uniq_ids.txt
    seqtk subseq "$FORWARD" "$LIBNAME"_uniq_ids.txt > "$LIBNAME"_mito_1.fq
    seqtk subseq "$REVERSE" "$LIBNAME"_uniq_ids.txt > "$LIBNAME"_mito_2.fq
    perl ../FastqPairedEndValidator.pl "$LIBNAME"_mito_1.fq "$LIBNAME"_mito_2.fq
    gzip "$LIBNAME"_mito_1.fq
    gzip "$LIBNAME"_mito_2.fq
else
    echo "The reads have already been extracted from the original fastq files. Skipping."
fi

# remake the depth file each time
echo "Getting the avg map depth from the bam file using bedtools"
samtools view -b "$LIBNAME".sorted.bam | genomeCoverageBed -ibam stdin -g "$SCAFFOLD" -d > "$SCAFFOLD"_depth.txt 
cat "$SCAFFOLD"_depth.txt | awk '{sum+=$3} END { print "Average = ",sum/NR}' >> "$LIBNAME"_mapdepthavg.txt
cat "$LIBNAME"_mapdepthavg.txt
