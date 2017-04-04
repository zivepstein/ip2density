# ip2density
ip2density is an R-script designed to generate the population density corresponding to a given IP address. A common usage for this is generating the associated population densities for the participants of a survey on Mechanical Turk. 

<h1>Installation</h1>
Simply clone this repository to your local machine with `git clone https://github.com/zivepstein/ip2density` then in an R console, run `source("/path/to/ip2density/ip2zip2density.R")`.

<h1>Usage</h1>
This script has several functions of use.
<b>generate_cols</b> takes as input a vector of IP addresses as strings and returns a data frame fields corresponding to the original IP's. The fields included are 
<ol>
<li>the original IP </li>
<li>the country code</li>
<li>the country</li>
<li>the region code (i.e. US State)</li>
<li>the region name </li>
<li>the city</li>
<li> <b>the corresponding zip code</b></li>
<li>the time zone</li>
<li>the latitude</li>
<li>the longitude</li>
<li>the metro code</li>
<li>and <b>the population density </b>of that zipcode. </li>
</ol>

Example:
`generate_cols(c("134.173.194.190", "68.65.169.6"))` returns 

| ip |country_code | country_name | region_code | region_name |  city | zip_code | time_zone | latitude | longitude | metro_code | density_from_zip | 
|----------------|----|---------------|-----|------------|----------|-------|---------------------|---------|------------|----|----------|
| 68.65.169.6     | US | United States | CA  | California | Stanford | 94305 | America/Los_Angeles | 37.4178 | -122.172   | 807  | 2703.198 |
| 134.173.194.190 | US | United States | CA  | California | Claremont| 91711 | America/Los_Angeles | 34.1223 | -117.7143  | 803         | 2378.589 |

<b>ip2vec</b> is a helper function that takes a IP address as a string and returns a vector of associated data. 

<b>zip2pop</b> is a data set used to map zip codes to population density. This dataset has a column for over 33k zipcodes (zip2pop$Zip.ZCTA) and a column for the corresponding population density (zip2pop$Density.Per.Sq.Mile).

