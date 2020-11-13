# Divewatchr R package

The aim of this repository is the creation of a R package for a thorough visualization and exploration of a SCUBA Diving Logbook, including spatio-temporal and categorical plots and maps.


The following images shown here will seem incomplete because of the lack of high quality data in the dataset, for example, maximumDepthInMeters, locationID and bottomTime were not recorded for all the dives. This depends only on the database and not on the functions


[Installation](#installation)
[Dives distribution map](#dives-distribution-map)
[Logged dives depths](#logged-dives-depths)
[Cumulative number of dives](#cumulative-number-of-dives)
[Number of dive types](#number-of-dive-types)

[Dives per country and region](#dives-per-country-and-region)

[Dive sites depths variation](#dive-sites-depths-variation)

[Platform type dives](#platform-type-dives)

[Semantic versioning](#semantic-versioning)


## Installation

Installing `divewatchr` requires the `devtools` package:

```r
install.packages("devtools")
devtools::install.github("rubenpp7/divewatchr")
library(divewatchr)

# Data load
prep_data()
```


```
  eventDate maximumDepthInMeters bottomTime            locationID       locality region country decimalLatitude decimalLongitude platformType
 1999-01-18                 32.1         44                 Tug 2         Exiles Sliema   Malta        35.91933        14.498331    shoreDive
 1999-01-24                 31.3         32          Um El-Faroud Zurrieq Valley Qrendi   Malta        35.81909        14.449771    shoreDive
 1999-02-09                 10.8         43 La Cueva de la Virgen   Cabo de Cope Murcia   Spain        37.42451        -1.500004     boatDive
 1999-03-31                 30.1         36 La Cueva de la Virgen   Cabo de Cope Murcia   Spain        37.42451        -1.500004     boatDive
 1999-04-19                  7.4         29  Pared Sur del Fraile        Aguilas Murcia   Spain        37.40743        -1.547101    shoreDive
 1999-04-20                 25.9         33 La Cueva de la Virgen   Cabo de Cope Murcia   Spain        37.42451        -1.500004     boatDive

```




## Dives distribution map

Access the interactive map here:
<a href="https://rubenpp7.github.io/" target="_blank">https://rubenpp7.github.io/</a> <i> open it in a new tab </i>
```r
logbook_map()

```
![](images/logbook_map2.png)

***


## Logged dives depths


```r
logged depths()

```
![](images/logged_depths.png)  

***


## Cumulative number of dives
Cumulative hard-to-understand fancy mega-plot.
<i> The blue vertical dashed lines mark the date when I completed my OWD, AOWD, Rescue and Divemaster courses </i>

```r
cum_dives()

```
![](images/cum_dives.png)  

***
***  
***


## Number of dive types

```r
divetypes()

```
![](images/dive_types.png)

***


## Dives per country and region

```r
divecount_reg()

```
![](images/divecount_reg.png)

***


## Dive sites depths variation

```r
divesite_depths()

```
![](images/divesite_depths.png)

***


## Platform type dives

```r
divetypes_platform()

```
![](images/platform_types.png)

***


###  Semantic versioning
Use [semantic versioning](https://semver.org/), i.e. 

* 1.0.0 first version

* 1.0.2 small changes or bug fixes

* 1.2.x bigger changes

* 2.x.x huge changes

***  
***

<!-- ### Contact -->
<!-- * [Twitter](https://twitter.com/maikspaik) -->
<!-- * [Instagram](https://www.instagram.com/ruben.pperez/?hl=en) -->
