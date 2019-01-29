# Input:
#   - counts
#   - class
#
# Output:
#   - p-values
#   - BH-adjusted p-values

library(DESeq)
library(limma)
DESeq.cds = newCountDataSet(countData = counts,
                            conditions = factor(class))
DESeq.cds = estimateSizeFactors(DESeq.cds)
DESeq.cds = estimateDispersions(DESeq.cds, method = "blind",
                                fitType = "local")
DESeq.vst = getVarianceStabilizedData(DESeq.cds)
DESeq.vst.fitlimma = lmFit(DESeq.vst, design = model.matrix(~factor(class)))
DESeq.vst.fitbayes = eBayes(DESeq.vst.fitlimma)
DESeq.vst.pvalues = DESeq.vst.fitbayes$p.value[, 2]
DESeq.vst.adjpvalues = p.adjust(DESeq.vst.pvalues, method = "BH")
