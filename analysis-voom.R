# Input:
#   - counts
#   - class
#
# Output:
#   - p-values
#   - BH-adjusted p-values

library(limma)
nf = calcNormFactors(counts, method = "TMM")
voom.data = voom(counts, design = model.matrix(~factor(class)),
                 lib.size = colSums(counts) * nf)
voom.data$genes = rownames(counts)
voom.fitlimma = lmFit(voom.data, design = model.matrix(~factor(class)))
voom.fitbayes = eBayes(voom.fitlimma)
voom.pvalues = voom.fitbayes$p.value[, 2]
voom.adjpvalues = p.adjust(voom.pvalues, method = "BH")
