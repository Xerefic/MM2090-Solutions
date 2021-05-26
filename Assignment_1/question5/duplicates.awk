#!/usr/bin/gawk -f
BEGIN{
	FC = ",";
};

{
	# Removing more than one instane of each student
	name[$1]=$0;
};

END{
	for (id in name){
		print name[id];
	};
};
