#!/bin/perl

while(<>)
{
  chomp;
  ($host,$port)=split / /,$_;
  #print "h=$host, p=$port.\n";
  print "\nHost $host\n  hostname 200.40.31.120\n  Port $port\n  User root\n";
}

