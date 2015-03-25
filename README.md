Popoolation Reports
===================

In this repository I include several Rscript for generate a report for the [Popoolation](https://code.google.com/p/popoolation/) software.
Each script generates a pdf file with a summary and several plots, and a text file that only includes the average statistic (for it
use in other programs inputs).

---

## Scripts

Already implemented scripts:

* [reportTheta.R](https://github.com/magicDGS/popoolation_reports/blob/master/reportTheta/reportTheta.R) : Reports Watterson's theta for a single file. 

---

## Usage

The complete usage is obtained with the command:

```
Rscript reportName/reportName.R

```

---

## Dependencies

The scripts check the R packages dependencies and try to install them. Pandoc should be installed manually.

* R packages:
  - ggplot2
  - rmarkdown
* Pandoc: see [RStudio Installing PANDOC](https://github.com/rstudio/rmarkdown/blob/master/PANDOC.md)
* LaTex support for your platform

---

## License

This script and template.Rmd is under a [MIT License](http://opensource.org/licenses/MIT)