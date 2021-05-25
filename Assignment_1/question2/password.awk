#!/usr/bin/gawk -f
BEGIN{
	FS = ",";
};

{	
	roll = $1;
	name = $2;
	depart = substr(roll, 1, 2);
	id = substr(roll, 6, 3);
	group = tolower(substr(roll, 5, 1));
	len_name = length(name);
	printf("%s,%s,%s%s%s%s\n", roll, name, depart, id, len_name, group);

};

END{
};
