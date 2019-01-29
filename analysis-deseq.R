# Input:
#   - counts
#   - class
#
# Output:
#   - p-values
#   - BH-adjusted p-values

library(DESeq)
DESeq.cds = newCountDataSet(countData = counts, conditions = factor(class))
DESeq.cds = estimateSizeFactors(DESeq.cds)
DESeq.cds = estimateDispersions(DESeq.cds, sharingMode = "maximum",
                                method = "pooled", fitType = "local")
DESeq.test = nbinomTest(DESeq.cds, "1", "2")
DESeq.pvalues = DESeq.test$pval
DESeq.adjpvalues = p.adjust(DESeq.pvalues, method = "BH")
