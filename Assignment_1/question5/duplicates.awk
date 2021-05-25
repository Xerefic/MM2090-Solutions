#!/usr/bin/gawk -f
BEGIN{
	FC = ",";
};

{
	name[$NF]=$0;
};

END{
	for (id in name){
		print name[id];
	};
};
