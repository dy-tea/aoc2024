<?php

function area_and_circ(&$lines, &$visited, $x, $y) {
  $queue = array(array($x, $y));
  $target = $lines[$y][$x];

  $dirs = array(
    array(1, 0),
    array(0, -1),
    array(0, 1),
    array(-1, 0),
  );

  $area = 0;
  $circ = 0;

  while (count($queue) > 0) {
    $curr = array_shift($queue);
    $cx = $curr[0];
    $cy = $curr[1];

    if ($cx >= 0 && $cx < strlen($lines[$cy]) && $cy >= 0 && $cy < count($lines) && $lines[$cy][$cx] == $target && !isset($visited["$cx,$cy"])) {
      $visited["$cx,$cy"] = true;
      $area += 1;

      foreach ($dirs as $dir) {
        $dx = $cx + $dir[0];
        $dy = $cy + $dir[1];

        if ($dx < 0 || $dy < 0 || $dy >= count($lines) || $dx >= strlen($lines[$dy]) || $lines[$dy][$dx] != $target) {
          $circ += 1;
        } else {
          $queue[] = array($dx, $dy);
        }
      }
    }
  }

  return array($area, $circ);
}

function p1() {
  // Read file into lines
  $file = fopen("input", "r") or die("Cannot open file");
  $lines = array();
  while(!feof($file)) {
    $lines[] = trim(fgets($file));
  }

  // Calculate the sum of products
  $visited = array();
  $sum = 0;

  for ($j = 0; $j != count($lines); $j++) {
    for ($i = 0; $i != strlen($lines[$j]); $i++) {
      $ca = area_and_circ($lines, $visited, $i, $j);
      $sum += $ca[0] * $ca[1];
    }
  }

  // Print
  print "$sum\n";
}

function p2() {
  // Read file into lines
  $file = fopen("input2", "r") or die("Cannot open file");
  $lines = array();
  while(!feof($file)) {
    $lines[] = trim(fgets($file));
  }
  // Calculate the sum of products
  $visited = array_fill(0, count($lines), array_fill(0, strlen($lines[0]), false));
  $sum = 0;

  for ($i = 0; $i < count($lines); $i++) {
    for ($j = 0; $j < strlen($lines[$i]); $j++) {
      if (!$visited[$i][$j]) {
        // TODO
      }
    }
  }

  // Print
  print "$sum\n";
}

p1();
p2();

?>
