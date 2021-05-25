#!/usr/bin/gawk -f
BEGIN{
	FC=","
};

{
	data[$NF]=$0;
	name[$NF]++;
};

END{
	for (id in name){
		printf("%s, %d\n", data[id], name[id]);
	};
};
