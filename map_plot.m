

zip1 = MyData(1:10801,2);
zip2 = zipcode(:,1);
c = zipcode( ismember( zip2, zip1),: );

lat = c(:,2);lon=c(:,3);


rent = tent( find(ismember( zip1, zip2)),2);

figure;
scatter(lon,lat,5,rent,'Filled');