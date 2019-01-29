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

* Simulate
  * B_625_625
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

## Changes

In the current version of NBPSeq (0.3.0), it is no longer possible to set `model.disp = "NBP"`:

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
