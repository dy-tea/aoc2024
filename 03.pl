#!/usr/bin/perl

use warnings;
use strict;
use v5.14;

# Part 1

my $file = 'input';
my $sum = 0;

open(FH, '<', $file) or die $!;

while (<FH>) {
  while (/mul\((\d+),(\d+)\)/g) {
    $sum += $1 * $2 
  }
}

print($sum, "\n");
close(FH);

# Part 2

$sum = 0;
my $enabled = 1;

open(FH, '<', $file) or die $!;

while (<FH>) {
  while (/(do\(\)|don't\(\)|mul\((\d+),(\d+)\))/g) {
    if ($1 eq 'do()') {
        $enabled = 1;
    } elsif ($1 eq "don't()") {
        $enabled = 0;
    } elsif ($enabled) {
        $sum += $2 * $3;
    }
  }
}

print($sum, "\n");
close(FH);

