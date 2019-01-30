# dsc-soneson-2013

[![Travis-CI Build Status](https://travis-ci.org/jdblischak/dsc-soneson-2013.svg?branch=master)](https://travis-ci.org/jdblischak/dsc-soneson-2013)

Create a DSC for [Soneson & Delorenzi, 2013][soneson2013] using the functions
provided by the companion Bioconductor package [compcodeR][].

[compcodeR]: https://www.bioconductor.org/packages/release/bioc/html/compcodeR.html
[soneson2013]: https://bmcbioinformatics.biomedcentral.com/articles/10.1186/1471-2105-14-91

## Installation

```
conda env create --file environment.yaml
```

## Modules

* Simulate (see Table 3)
  * b_0_0: No DE genes
  * b_1250_0: 1250 DE up
  * b_625_625: 625 DE up, 625 DE down
  * b_4000_0: 4000 DE up
  * b_2000_2000: 2000 DE up, 2000 DE down
  * p_0_0: No DE genes, 50% Poisson variation
  * p_625_625: 625 DE up, 625 DE down, 50% Poisson variation
  * s_0_0: No DE genes, 10% outliers per sample
  * s_625_625: 625 DE up, 625 DE down, 10% outliers per sample
  * r_0_0: No DE genes, 5% outliers total
  * r_625_625: 625 DE up, 625 DE down, 5% outliers total
* Analyze (11)
  * edgeR
  * DESeq
  * NBPSeq
  * baySeq
  * EBSeq
  * TSPM
  * SAMseq
  * NOISeq
  * voom+limma
  * vst+limma
  * ShrinkSeq
* Score
  * AUC
  * Type I error rate
  * True false discovery rate (for FDR threshold of 0.05)

## Pipelines

They didn't perform all possible combinations of data sets, methods, and scores.

For the area under the ROC curve (Figure 1), they only used simulated data
sets with differentially expressed genes and all 11 methods.

* (b_1250_0, b_625_625, b_4000_0, b_2000_2000, s_625_625, r_625_625) ->
(edgeR, DESeq, NBPSeq, TSPM, voom+limma, vst+limma, baySeq, EBSeq, ShrinkSeq, SAMseq, NOISeq) ->
auc

For measuring the type I error rate (Figure 3), they only used simulated data
sets with no differentially expressed genes and methods that returned p-values.

* (b_0_0, p_0_0, s_0_0, r_0_0) ->
(edgeR, DESeq, NBPSeq, TSPM, voom+limma and vst+limma) ->
type I error rate

For the true false discovery rates (Figure 4), they only used simulated data
sets with differentially expressed genes and methods that returned adjusted
p-values.

* (b_1250_0, b_625_625, b_4000_0, b_2000_2000, s_625_625, r_625_625) ->
(edgeR, DESeq, NBPSeq, TSPM, voom+limma, vst+limma, baySeq, EBSeq, ShrinkSeq, SAMseq) ->
true false discovery rates

## Changes

In the current version of NBPSeq (0.3.0), it is no longer possible to set
`model.disp = "NBP"`:

```
NBPSeq.test = nbp.test(counts = counts, grp.ids = class,
                       grp1 = 1, grp2 = 2, norm.factors = NBPSeq.norm.factors,
                       method.disp = "NBP")
## Create NBP data structure.
## Use specified normalization factors.
## Thin the counts to make library sizes approximately equal.
## Estimate NB dispersion.
## Error in fn(par, ...) : unused argument (method.disp = "NBP")
```

The only way I could get it to run was by omitting this argument entirely, which
then uses the default of `"NBQ"`. The [CRAN
page](https://cran.r-project.org/package=NBPSeq) doesn't list a website, so it
doesn't seem worth investigating further.

## Resources

* [compcodeR GitHub repo](https://github.com/csoneson/compcodeR)
* [compcodeR on Bioconductor][compcodeR]
* [compcodeR on Anaconda Cloud](https://anaconda.org/bioconda/bioconductor-compcoder)
* [Additional File 1][supp]

[supp]: https://static-content.springer.com/esm/art%3A10.1186%2F1471-2105-14-91/MediaObjects/12859_2012_5756_MOESM1_ESM.pdf
