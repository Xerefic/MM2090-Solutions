#!/usr/bin/gawk -f
BEGIN{
	FC=","
};

{
	# Counting the number of occurence of each roll number in the combined attendance file
	data[$1]=$0;
	name[$1]++;
};

END{
	for (id in name){
		printf("%s, %d\n", data[id], name[id]);
	};
};
