#!/usr/bin/env dsc

# Simulate ---------------------------------------------------------------------

simulate: simulate.R
  samples_per_cond: 2, 5, 10
  n_diffexp: 0, 1250, 4000
  $counts: d@count.matrix
  $class: d@sample.annotations[, "condition"]

# Analysis ---------------------------------------------------------------------

edger: analysis-edger.R
  counts: $counts
  class: $class
  $pval: edgeR.pvalues
  $pval_adj: edgeR.adjpvalues

deseq: analysis-deseq.R
  counts: $counts
  class: $class
  $pval: DESeq.pvalues
  $pval_adj: DESeq.adjpvalues

# Run --------------------------------------------------------------------------

DSC:
  define:
    analyze: edger, deseq
  run: simulate * analyze
