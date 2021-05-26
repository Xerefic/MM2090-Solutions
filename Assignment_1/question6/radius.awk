#!/usr/bin/gawk -f
BEGIN{
	FS = "\t";
	# Choosing element 32 Ge with Atomic Radius 1.25
	key = 1.25;
	# Printing the header
	printf("Atomic Number,Element,Atomic Radii,Deviation\n")
	printf("32,Ge,1.25,0\%\n");
};

{	
	# Getting the absolute difference in atomic radii between the chosen element and iterated
	diff = $3-key;
	if (diff<0) diff = -1*diff;

	# Checking if the deviation is <10% and outputting if True
	if (diff<=key*0.1 && $1!=32) printf("%d,%s,%.2f,%.2f\%\n", $1, $2, $3,diff/key*100);
};

END{
};
