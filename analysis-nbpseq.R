# Input:
#   - counts
#   - class
#
# Output:
#   - p-values
#   - BH-adjusted p-values

library(limma)
library(edgeR)
library(NBPSeq)
NBPSeq.dgelist = DGEList(counts = counts, group = factor(class))
NBPSeq.dgelist = calcNormFactors(NBPSeq.dgelist, method = "TMM")
NBPSeq.norm.factors = as.vector(NBPSeq.dgelist$samples$norm.factors)
NBPSeq.test = nbp.test(counts = counts, grp.ids = class,
                       grp1 = 1, grp2 = 2, norm.factors = NBPSeq.norm.factors)
NBPSeq.pvalues = NBPSeq.test$p.values
NBPSeq.adjpvalues = NBPSeq.test$q.values
