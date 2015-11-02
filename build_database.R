setwd('./')

library(xlsx)
library(RCurl)
library(rhdf5)


INDICATOR_TYPE <- cbind("R", "M","")
AREA_CATEGORY  <- cbind("COUNTY","CITY","HOOD","METRO","ZIP","STATE")
INDICATOR_CODE <- cbind("MEDIANVALUEPERSQFT_ALLHOMES","ZRIPERSQFT_ALLHOMES","PRICETORENTRATIO_ALLHOMES","MEDIANSOLDPRICEPERSQFT_ALLHOMES","PCTOFHOMESINCREASINGINVALUES_ALLHOMES","PCTOFHOMESDECREASINGINVALUES_ALLHOMES","NUMBEROFHOMESFORSALE_ALLHOMES","NUMBEROFHOMESFORRENT_ALLHOMES")

#State       <- read.xlsx('database/quandl-area-codes.xlsx', 1)
#Metropolitan<- read.xlsx('database/quandl-area-codes.xlsx', 2)
#Counties    <- read.xlsx('database/quandl-area-codes.xlsx', 3)
#Cities      <- read.xlsx('database/quandl-area-codes.xlsx', 4)
Zip_codes   <- read.xlsx('database/quandl-area-codes.xlsx', 5)
#Neighbour   <- read.xlsx('database/quandl-area-codes.xlsx', 6)

filename="database/Zip_info.h5"
h5createFile(filename)

url0 <- "http://www.quandl.com/api/v1/datasets/ZILLOW/"

for (n in 1:dim(Zip_codes)[1]){
url_address <- paste(url0,INDICATOR_TYPE[2],AREA_CATEGORY[5],'_',INDICATOR_CODE[3],'_',Zip_codes[n,][1],".csv",sep="")
url_address <- paste(url_address, "?auth_token=nFTiySsfZJhs1PPLmsQF",sep="")
groupname = as.character(Zip_codes[n,1])
cat(sprintf("check for %s \n", url_address))
Sys.sleep(2)
if (url.exists(url_address)){
	Zip_Rent_Per_Sqft <- read.csv(url_address,sep=',',head=TRUE)
	h5createGroup(filename, groupname)
	h5write(Zip_Rent_Per_Sqft[,2], filename, paste(as.character(Zip_codes[n,1]),'/Price_to_rent_ratio',sep=''))
	cat(sprintf("found data in zipcode------------------------------------- %g \n", Zip_codes[n,][1]))
	}
}
stop('done with price to rent ratio')

for (n in 1:dim(Zip_codes)[1]){
url_address <- paste(url0,INDICATOR_TYPE[1],AREA_CATEGORY[5],'_',INDICATOR_CODE[2],'_',Zip_codes[n,][1],".csv",sep="")
url_address <- paste(url_address, "?auth_token=nFTiySsfZJhs1PPLmsQF",sep="")
groupname = as.character(Zip_codes[n,1])
cat(sprintf("check for %s \n", url_address))
Sys.sleep(2)
if (url.exists(url_address)){
	Zip_Rent_Per_Sqft <- read.csv(url_address,sep=',',head=TRUE)
	h5createGroup(filename, groupname)
	h5write(Zip_Rent_Per_Sqft[,2], filename, paste(as.character(Zip_codes[n,1]),'/Rent_Per_Sqft',sep=''))
	cat(sprintf("found data in zipcode------------------------------------- %g \n", Zip_codes[n,][1]))
	}
}
