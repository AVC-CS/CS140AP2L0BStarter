#!/bin/sh
# Run every example program in MARS on each of ITS data sets.
# result_<prog>_N.txt <- data/<prog>_dataN.txt holds the program's own output, then one
# `Mem[0x...]` line per four words of the MEM range (printed after the run).
#
#   nc        no copyright banner          sm   start at the `main` label
#   ae1 se2   exit 1 on an assembly error, exit 2 on a runtime error
#   1000000   step limit, so an endless loop ends (timeout is the second guard)
#   MEM       the .data range the tests read.
MEM=0x10010000-0x1001003c
status=0
for p in ex4 ex5 ex6; do
  for f in data/${p}_data*.txt; do
    n=$(basename "$f" .txt | sed "s/^${p}_data//")
    timeout 10 java -jar Mars4_5.jar nc sm ae1 se2 1000000 $MEM $p.asm < "$f" > "result_${p}_$n.txt" || status=1
  done
done
exit $status
