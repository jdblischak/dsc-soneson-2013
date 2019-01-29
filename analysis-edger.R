# Input:
#   - counts
#   - class
#
# Output:
#   - p-values
#   - BH-adjusted p-values

library(edgeR)
edgeR.dgelist = DGEList(counts = counts, group = factor(class))
edgeR.dgelist = calcNormFactors(edgeR.dgelist, method = "TMM")
edgeR.dgelist = estimateCommonDisp(edgeR.dgelist)
edgeR.dgelist = estimateTagwiseDisp(edgeR.dgelist, trend = "movingave")
edgeR.test = exactTest(edgeR.dgelist)
edgeR.pvalues = edgeR.test$table$PValue
edgeR.adjpvalues = p.adjust(edgeR.pvalues, method = "BH")
