#!/usr/bin/env dsc

# Simulate ---------------------------------------------------------------------

b_0_0_data: simulate.R
  samples_per_cond: 2, 5, 10
  n_diffexp: 0
  fraction_upregulated: 1
  $counts: d@count.matrix
  $class: d@sample.annotations[, "condition"]
  $truth: d@variable.annotations[, "differential.expression"]

b_1250_0_data: simulate.R
  samples_per_cond: 2, 5, 10
  n_diffexp: 1250
  fraction_upregulated: 1
  $counts: d@count.matrix
  $class: d@sample.annotations[, "condition"]
  $truth: d@variable.annotations[, "differential.expression"]

b_625_625_data: simulate.R
  samples_per_cond: 2, 5, 10
  n_diffexp: 1250
  fraction_upregulated: 0.5
  $counts: d@count.matrix
  $class: d@sample.annotations[, "condition"]
  $truth: d@variable.annotations[, "differential.expression"]

b_4000_0_data: simulate.R
  samples_per_cond: 2, 5, 10
  n_diffexp: 4000
  fraction_upregulated: 1
  $counts: d@count.matrix
  $class: d@sample.annotations[, "condition"]
  $truth: d@variable.annotations[, "differential.expression"]

b_2000_2000_data: simulate.R
  samples_per_cond: 2, 5, 10
  n_diffexp: 4000
  fraction_upregulated: 0.5
  $counts: d@count.matrix
  $class: d@sample.annotations[, "condition"]
  $truth: d@variable.annotations[, "differential.expression"]

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

# Score ------------------------------------------------------------------------

type_one_error: R(x <- mean(pval < 0.05))
  pval: $pval
  $type_one_error: x

# Run --------------------------------------------------------------------------

DSC:
  define:
    zeros: b_0_0_data
    de: b_1250_0_data, b_625_625_data, b_4000_0_data, b_2000_2000_data
    analyze: edger, deseq, nbpseq, voom, vst
  run: zeros * analyze * type_one_error
