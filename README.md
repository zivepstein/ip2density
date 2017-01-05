# ip2density
ip2density is an R-script designed to generate the population density corresponding to a given IP address. A common usage for this is generating the associated population densities for the participants of a survey on Mechanical Turk. 

<h1>Installation</h1>
Simply clone this repository to your local machine with `git clone https://github.com/zivepstein/ip2density` then in an R console,run `source("/path/to/ip2density/ip2zip2density.R")`.

<h1>Usage</h1>
This script has several functions of use.
<b>generate_cols</b> takes as input a vector of IP addresses as strings and returns a data frame with the original IP's, the corresponding zip codes and the density of that zipcode. 

<b>ip2zip</b> is a helper function that takes a IP address as a string and returns the corresponding zip code. 

<b>zip2pop</b> is a data set used to map zip codes to population density. This dataset has a column for over 33k zipcodes (zip2pop$Zip.ZCTA) and a column for the corresponding population density (zup2pop$Density.Per.Sq.Mile).
