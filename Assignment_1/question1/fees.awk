#!/usr/bin/gawk -f
BEGIN{
	FS = ",";
	sum = 0;
};

{
	roll = $1;
	year = int(substr(roll, 3, 2));
	
	num[year]++;	
	
};

END{
	for (year in num){
		rate = (1.1)**(year-17)*num[year];
		sum+= 20000*rate;
	}
       	print sum;	
};
