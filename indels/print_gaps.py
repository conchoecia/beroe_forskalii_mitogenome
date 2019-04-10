#from Bio import SeqIO
#for record in SeqIO.parse("Bf_alignment.fasta", "fasta"):
#    print(record.seq)
#!/bin/env/python python3
from Bio import AlignIO
alignment = AlignIO.read(open("Bf_alignment.fasta"), "fasta")

print("{}\t{}\t{}".format("Record", "GapStart", "GapLen"))
for record in alignment:
    in_gap = False
    gap_start = 0
    for i in range(0, len(record.seq)):
        if record.seq[i] == '-':
            if not in_gap:
                in_gap = True
                gap_start = i
        else:
            if in_gap:
                print("{}\t{}\t{}".format(record.id, gap_start + 1, i-gap_start)) 
                in_gap = False
