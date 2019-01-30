#!/usr/bin/env dsc

# Simulate ---------------------------------------------------------------------

b_0_0_data: simulate.R
  samples_per_cond: 2, 5, 10
  n_diffexp: 0
  fraction_upregulated: 1
  fraction_non_overdispersed: 0
  single_outlier_high_prob: 0
  random_outlier_high_prob: 0
  $counts: d@count.matrix
  $class: d@sample.annotations[, "condition"]
  $truth: d@variable.annotations[, "differential.expression"]

b_1250_0_data: simulate.R
  samples_per_cond: 2, 5, 10
  n_diffexp: 1250
  fraction_upregulated: 1
  fraction_non_overdispersed: 0
  single_outlier_high_prob: 0
  random_outlier_high_prob: 0
  $counts: d@count.matrix
  $class: d@sample.annotations[, "condition"]
  $truth: d@variable.annotations[, "differential.expression"]

b_625_625_data: simulate.R
  samples_per_cond: 2, 5, 10
  n_diffexp: 1250
  fraction_upregulated: 0.5
  fraction_non_overdispersed: 0
  single_outlier_high_prob: 0
  random_outlier_high_prob: 0
  $counts: d@count.matrix
  $class: d@sample.annotations[, "condition"]
  $truth: d@variable.annotations[, "differential.expression"]

b_4000_0_data: simulate.R
  samples_per_cond: 2, 5, 10
  n_diffexp: 4000
  fraction_upregulated: 1
  fraction_non_overdispersed: 0
  single_outlier_high_prob: 0
  random_outlier_high_prob: 0
  $counts: d@count.matrix
  $class: d@sample.annotations[, "condition"]
  $truth: d@variable.annotations[, "differential.expression"]

b_2000_2000_data: simulate.R
  samples_per_cond: 2, 5, 10
  n_diffexp: 4000
  fraction_upregulated: 0.5
  fraction_non_overdispersed: 0
  single_outlier_high_prob: 0
  random_outlier_high_prob: 0
  $counts: d@count.matrix
  $class: d@sample.annotations[, "condition"]
  $truth: d@variable.annotations[, "differential.expression"]

p_0_0_data: simulate.R
  samples_per_cond: 2, 5, 10
  n_diffexp: 0
  fraction_upregulated: 1
  fraction_non_overdispersed: 0.5
  single_outlier_high_prob: 0
  random_outlier_high_prob: 0
  $counts: d@count.matrix
  $class: d@sample.annotations[, "condition"]
  $truth: d@variable.annotations[, "differential.expression"]

p_625_625_data: simulate.R
  samples_per_cond: 2, 5, 10
  n_diffexp: 1250
  fraction_upregulated: 0.5
  fraction_non_overdispersed: 0.5
  single_outlier_high_prob: 0
  random_outlier_high_prob: 0
  $counts: d@count.matrix
  $class: d@sample.annotations[, "condition"]
  $truth: d@variable.annotations[, "differential.expression"]

s_0_0_data: simulate.R
  samples_per_cond: 2, 5, 10
  n_diffexp: 0
  fraction_upregulated: 1
  fraction_non_overdispersed: 0
  single_outlier_high_prob: 0.10
  random_outlier_high_prob: 0
  $counts: d@count.matrix
  $class: d@sample.annotations[, "condition"]
  $truth: d@variable.annotations[, "differential.expression"]

s_625_625_data: simulate.R
  samples_per_cond: 2, 5, 10
  n_diffexp: 1250
  fraction_upregulated: 0.5
  fraction_non_overdispersed: 0
  single_outlier_high_prob: 0.10
  random_outlier_high_prob: 0
  $counts: d@count.matrix
  $class: d@sample.annotations[, "condition"]
  $truth: d@variable.annotations[, "differential.expression"]

r_0_0_data: simulate.R
  samples_per_cond: 2, 5, 10
  n_diffexp: 0
  fraction_upregulated: 1
  fraction_non_overdispersed: 0
  single_outlier_high_prob: 0
  random_outlier_high_prob: 0.05
  $counts: d@count.matrix
  $class: d@sample.annotations[, "condition"]
  $truth: d@variable.annotations[, "differential.expression"]

r_625_625_data: simulate.R
  samples_per_cond: 2, 5, 10
  n_diffexp: 1250
  fraction_upregulated: 0.5
  fraction_non_overdispersed: 0
  single_outlier_high_prob: 0
  random_outlier_high_prob: 0.05
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

auc: score-auc.R
  pval_adj: $pval_adj
  truth: $truth
  $auc: auc

type_one_error: R(x <- mean(pval < 0.05, na.rm = TRUE))
  pval: $pval
  $type_one_error: x

true_fdr: R(x <- sum(pval_adj < 0.05 & !truth, na.rm = TRUE) / sum(pval_adj < 0.05, na.rm = TRUE))
  pval_adj: $pval_adj
  truth: $truth
  $true_fdr: x

# Run --------------------------------------------------------------------------

DSC:
  define:
    zeros: b_0_0_data, p_0_0_data, s_0_0_data, r_0_0_data
    de: b_1250_0_data, b_625_625_data, b_4000_0_data, b_2000_2000_data,
        p_625_625_data, s_625_625_data, r_625_625_data
    analyze: edger, deseq, nbpseq, voom, vst
  run:
    de * analyze * auc,
    zeros * analyze * type_one_error,
    de * analyze * true_fdr
