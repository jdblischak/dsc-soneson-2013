#!/usr/bin/env Rscript

library(dscrutils)

# type I error rate
df_t1 <- dscquery("soneson2013/",
                  targets = c("zeros",
                              "analyze",
                              "type_one_error.type_one_error"))
df_t1 <- df_t1[, !grepl("output.file", colnames(df_t1))]
print(df_t1)

# true FDR
df_fdr <- dscquery("soneson2013/",
                   targets = c("de",
                               "analyze",
                               "true_fdr.true_fdr"))
df_fdr <- df_fdr[, !grepl("output.file", colnames(df_fdr))]
print(df_fdr)
