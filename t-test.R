#!/usr/bin/env Rscript

require(genefilter)
require(edgeR)

cdata <- readRDS('B_625_625_5spc_repl1.rds')
is.valid <- check_compData(cdata)
if (!(is.valid == TRUE)) stop('Not a valid compData object.')
nf <- edgeR::calcNormFactors(count.matrix(cdata), method = 'TMM') * colSums(count.matrix(cdata))/exp(mean(log(colSums(count.matrix(cdata)))))
count.matrix <- round(sweep(count.matrix(cdata), 2, nf, '/'))
ttest.result <- genefilter::rowttests(count.matrix, factor(sample.annotations(cdata)$condition))
ttest.pvalues <- ttest.result$p.value
ttest.adjpvalues <- p.adjust(ttest.pvalues, method = 'BH')
ttest.logFC <- ttest.result$dm
ttest.score <- 1 - ttest.pvalues
result.table <- data.frame('pvalue' = ttest.pvalues, 'adjpvalue' = ttest.adjpvalues, 'logFC' = ttest.logFC, 'score' = ttest.score)
rownames(result.table) <- rownames(count.matrix(cdata))
result.table(cdata) <- result.table
package.version(cdata) <- paste('edgeR,', packageVersion('edgeR'), ';', 'genefilter,', packageVersion('genefilter'))
analysis.date(cdata) <- date()
method.names(cdata) <- list('short.name' = 'ttest', 'full.name' = 'ttest.1.64.0.TMM')
is.valid <- check_compData_results(cdata)
if (!(is.valid == TRUE)) stop('Not a valid compData result object.')
saveRDS(cdata, '/home/jdb-work/Desktop/dsc-soneson-2013/B_625_625_5spc_repl1_ttest.rds')
print(paste('Unique data set ID:', info.parameters(cdata)$uID))
