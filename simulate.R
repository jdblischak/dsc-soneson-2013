#!/usr/bin/env Rscript

# Simulate data sets
#
# See Table 3
#
# https://bmcbioinformatics.biomedcentral.com/articles/10.1186/1471-2105-14-91#Sec10

library(compcodeR)

d <- generateSyntheticData(
  dataset = paste(samples_per_cond, n_diffexp, sep = "-"),
  n.vars = 12500,
  samples.per.cond = samples_per_cond,
  n.diffexp = n_diffexp,
  repl.id = 1,
  seqdepth = 1e7,
  fraction.upregulated = fraction_upregulated,
  between.group.diffdisp = FALSE,
  filter.threshold.total = 1,
  filter.threshold.mediancpm = 0,
  fraction.non.overdispersed = fraction_non_overdispersed,
  single.outlier.high.prob = single_outlier_high_prob,
  random.outlier.high.prob = random_outlier_high_prob,
  output.file = NULL
)
