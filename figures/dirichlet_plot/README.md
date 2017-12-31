- The command used to generate these graphs was:
  - `cuttlery dirichlet --coding_dir ../../fasta_sequences/coding_seqs/ --noncoding_dir ../../fasta_sequences/noncoding_seqs/ --test_dir ../../fasta_sequences/test_seqs/ --numsims 1000000 --results_file dirichlet_results_1M.csv -s meandec --fileform pdf`
- The confusion matrix, false positive rate, and power for the two test genes were:

```
confusion matrix
[[8907034  502877]
 [4541616 4937343]]
ND2L marginalized false positive rate: 0.0
ND2L power: 0.9979154120404308
UNK marginalized false positive rate: 0.0
UNK power: 0.9976515167934705
```
