#!/bin/perl

do './tableau.pl';
use POSIX ();

open F,"template.yaml";
read F,$tpo,100000;
close F;

foreach $name (sort keys %ht)
{
    print "$name\n";
    $tp=$tpo;
    &repl('__name__',$name);
    &repl('__main__',$ht{$name}{'MAIN'});
    &repl('__io__',$ht{$name}{'IO'});
    $d=$ht{$name}{'disk'};
    $d/=(1024*1024*1024);
    $d=ceil($d);
    &repl('__size__',$d});
    open FF,">$name.yaml";
    print FF $tp;
    close FF;
}

sub repl
{
    my ($src,$dst)=@_;
    $tp=~s/$src/$dst/msg;
}
