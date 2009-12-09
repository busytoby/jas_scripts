#!/bin/perl --

srand (time);
#srand (time ^ $$ ^ unpack "%L*", `ps axww | gzip`);
rand($.) < 1 && ($adage = $_) while <>;
print $adage;
