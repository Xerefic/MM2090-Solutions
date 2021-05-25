#!/usr/bin/gawk -f
BEGIN{
	FC=","
};

{
	name[$1]++;
};

END{
	for (id in name){
		print id, name[id];
	};
};
