#!/usr/bin/gawk -f
BEGIN{
	FS = "\t";
	# Choosing element 32 Ge with Atomic Radius 1.25
	key = 1.25;
	printf("Atomic Number,Element,Atomic Radii\n")
	printf("32,Ge,1.25\n");
};

{	
	diff = $3-key;
	if (diff<0) diff = -1*diff;

	if (diff<=key*0.1 && $1!=32) printf("%d,%s,%.2f\n", $1, $2, $3);
};

END{
};
