#freegeoip, ip2zip and clean are functions that should be loaded in. zip2pop is a dataset that maps zips to population densiy, so load that in as well
script.dir <- dirname(sys.frame(1)$ofile)
data_url <- paste(script.dir,"/zip2popdensity_area.csv", sep="")
zip2pop <- read.csv(data_url)

freegeoip <- function(ip, format = ifelse(length(ip)==1,'list','dataframe'))
{
  if (1 == length(ip))
  {
    # a single IP address
    require(rjson)
    url <- paste(c("http://freegeoip.net/json/", ip), collapse='')
    ret <- fromJSON(readLines(url, warn=FALSE))
    if (format == 'dataframe')
      ret <- data.frame(t(unlist(ret)))
    return(ret)
  } else {
    ret <- data.frame()
    for (i in 1:length(ip))
    {
      r <- freegeoip(ip[i], format="dataframe")
      ret <- rbind(ret, r)
    }
    return(ret)
  }
}  

ip2zip <- function(x){
  return(freegeoip(toString(x))$zip_code)
}

ip2state <- function(x){
  return(freegeoip(toString(x))$region_code)
}

ip2vec <- function(x){
  return(freegeoip(toString(x)))
}

clean <- function(x){
  if (substr(x,1,1) == "0"){
    return(substr(x,2,5))
  } else{
    return(x)
  }
}

generate_cols <- function(input, from = "ip"){
  if (from == "ip"){
  zip_from_ip <- c()
  state_from_ip <- c()
  vec_from_ip <- c()
  for (ip in input){
    zip_from_ip <- c(zip_from_ip,ip2zip(ip))
    state_from_ip <- c(state_from_ip,ip2state(ip))
    vec_from_ip <- rbind(vec_from_ip, ip2vec(ip))
  }
  
  density_from_zip <- c()
  for (i in 1:length(zip_from_ip)){
    l <- zip2pop[which(zip2pop$Zip.ZCTA == clean(zip_from_ip[i])),]$Density.Per.Sq.Mile
    if (length(l) > 0){
      density_from_zip[i] <- l
    } else{
      density_from_zip[i] <- 0
    }
  }
  
  out <- data.frame(vec_from_ip)
  return(out)
  } else if (from == "zip"){
    density_from_zip <- c()
    for (i in 1:length(input)){
      l <- zip2pop[which(zip2pop$Zip.ZCTA == clean(input[i])),]$Density.Per.Sq.Mile
      if (length(l) > 0){
        density_from_zip[i] <- l
      } else{
        density_from_zip[i] <- 0
      }
    }
  return(density_from_zip)
  } else{
      return("from parameter must be 'zip' or 'ip'")
    }
}

#example calls
generate_cols(c("68.65.169.6","134.173.194.190"))
generate_cols(c("02141","80304"), from = "zip")
