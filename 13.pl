#!/usr/bin/perl

use warnings;
use strict;

# Part 1
my $file = 'input';

open(FH, '<', $file) or die $!;

sub calculate_presses {
  my ($ax, $ay, $bx, $by, $tx, $ty) = @_;
  my $min_presses = undef;

  for (my $i = 0; $i < 100; $i++) {
    for (my $j = 0; $j < 100; $j++) {
      my $current_x = $i * $ax + $j * $bx;
      my $current_y = $i * $ay + $j * $by;

      if ($current_x == $tx && $current_y == $ty) {
        my $total_presses = $i * 3 + $j;
        if (!defined $min_presses || $total_presses < $min_presses) {
          $min_presses = $total_presses;
        }
      }
    }
  }

  return $min_presses;
}

my ($ax, $ay, $bx, $by) = (0, 0, 0, 0);
my $sum = 0;

while (<FH>) {
  if (/(Button A: X\+(\d+), Y\+(\d+))/) {
    $ax = $2;
    $ay = $3;
  } elsif (/(Button B: X\+(\d+), Y\+(\d+))/) {
    $bx = $2;
    $by = $3;
  } elsif (/(Prize: X=(\d+), Y=(\d+))/) {
    my ($tx, $ty) = ($2, $3);
    my $presses = calculate_presses($ax, $ay, $bx, $by, $tx, $ty);
    $sum += $presses if defined $presses;
  }
}

print($sum, "\n");
close(FH);

# Part 2
$sum = 0;
open(FH, '<', $file) or die $!;

while (<FH>) {
  if (/(Button A: X\+(\d+), Y\+(\d+))/) {
    $ax = $2;
    $ay = $3;
  } elsif (/(Button B: X\+(\d+), Y\+(\d+))/) {
    $bx = $2;
    $by = $3;
  } elsif (/(Prize: X=(\d+), Y=(\d+))/) {
    my ($tx, $ty) = ($2 + 10000000000000, $3 + 10000000000000);

    my $b = $ay * $tx - $ax * $ty;
    my $n = $bx * $ay - $by * $ax;
    next if $b % $n;
    $b /= $n;

    my $a = $tx - $b * $bx;
    next if $a % $ax;
    $a /= $ax;

    $sum += 3 * $a + $b;
  }
}

print($sum, "\n");
close(FH);
