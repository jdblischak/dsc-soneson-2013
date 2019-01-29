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

nbpseq: analysis-nbpseq.R
  counts: $counts
  class: $class
  $pval: NBPSeq.pvalues
  $pval_adj: NBPSeq.adjpvalues

voom: analysis-voom.R
  counts: $counts
  class: $class
  $pval: voom.pvalues
  $pval_adj: voom.adjpvalues

vst: analysis-vst.R
  counts: $counts
  class: $class
  $pval: DESeq.vst.pvalues
  $pval_adj: DESeq.vst.adjpvalues

# Run --------------------------------------------------------------------------

DSC:
  define:
    analyze: edger, deseq, nbpseq, voom, vst
  run: simulate * analyze
