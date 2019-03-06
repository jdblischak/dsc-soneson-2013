#!/usr/bin/env Rscript

library(dplyr)
library(dscrutils)
library(stringr)

dir.create("data/", showWarnings = FALSE)

# area under the curve
df_auc <- dscquery("soneson2013/",
                  targets = c("de",
                              "de.samples_per_cond",
                              "analyze",
                              "auc.auc"))
df_auc <- df_auc[, !grepl("output.file", colnames(df_auc))]
df_auc <- na.omit(df_auc)
colnames(df_auc) <- c("dsc", "de", "samples_per_cond", "analyze", "auc")
df_auc$de <- str_replace(df_auc$de, "_data$", "")
df_auc$auc <- as.numeric(df_auc$auc)
df_auc[["dsc"]] <- NULL

print(df_auc)
print(summary(df_auc$auc))
tapply(df_auc$auc.auc, df_auc$de, mean)
tapply(df_auc$auc.auc, df_auc$analyze, mean)

write.table(df_auc, file = "data/auc.txt",
            quote = FALSE, sep = "\t", row.names = FALSE)

# type I error rate
df_t1 <- dscquery("soneson2013/",
                  targets = c("zeros",
                              "zeros.samples_per_cond",
                              "analyze",
                              "type_one_error.type_one_error"))
df_t1 <- df_t1[, !grepl("output.file", colnames(df_t1))]
df_t1 <- na.omit(df_t1)
df_t1$type_one_error.type_one_error <- as.numeric(df_t1$type_one_error.type_one_error)


print(df_t1)
print(summary(df_t1$type_one_error.type_one_error))
tapply(df_t1$type_one_error.type_one_error, df_t1$zeros, mean)
tapply(df_t1$type_one_error.type_one_error, df_t1$analyze, mean)

write.table(df_t1, file = "data/t1error.txt",
            quote = FALSE, sep = "\t", row.names = FALSE)

# true FDR
df_fdr <- dscquery("soneson2013/",
                   targets = c("de",
                               "de.samples_per_cond",
                               "analyze",
                               "true_fdr.true_fdr"))
df_fdr <- df_fdr[, !grepl("output.file", colnames(df_fdr))]
df_fdr <- na.omit(df_fdr)
df_fdr$true_fdr.true_fdr <- as.numeric(df_fdr$true_fdr.true_fdr)
print(df_fdr)
summary(df_fdr$true_fdr.true_fdr)
tapply(df_fdr$true_fdr.true_fdr, df_fdr$de, mean)
tapply(df_fdr$true_fdr.true_fdr, df_fdr$analyze, mean)

write.table(df_fdr, file = "data/fdr.txt",
            quote = FALSE, sep = "\t", row.names = FALSE)
