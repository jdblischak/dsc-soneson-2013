#!/usr/bin/env dsc

simulate: simulate.R
  samples_per_cond: 2, 5, 10
  n_diffexp: 0, 1250,
  $counts: d@count.matrix

t_test: t-test.R
  counts: $counts

DSC:
  run: simulate
