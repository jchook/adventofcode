<?php

// Part 1
echo array_sum(explode("\n", file_get_contents('./01a.txt')));

// Part 2
$memo = [0 => true];
$sum = 0;
$list = explode("\n", file_get_contents('./01a.txt'));
while (1) foreach ($list as $n) {
  if (isset($memo[$sum += $n])) {
    echo 'Found it: ' . $sum;
    exit;
  }
  $memo[$sum] = true;
}