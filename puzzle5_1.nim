# https://adventofcode.com/2020/day/5
# --- Part Two ---
# Ding! The "fasten seat belt" signs have turned on. Time to find your seat.
# 
# It's a completely full flight, so your seat should be the only missing boarding pass in your list. However, there's a catch: some of the seats at the very front and back of the plane don't exist on this aircraft, so they'll be missing from your list as well.
# 
# Your seat wasn't at the very front or back, though; the seats with IDs +1 and -1 from yours will be in your list.
# 
# What is the ID of your seat?
import strutils, sequtils, math, algorithm

var s = readFile("puzzle/puzzle5.txt").strip().splitLines()
var i = 0
var divider: int
var rows = toSeq(0..127)
var cols = toSeq(0..7)
var row_processed: seq[int]
var col_processed: seq[int]
# halves are denoted by false on the lower half and true on the upper half
var row_half = false
var col_half = false
var ids: seq[int]
var triple = @[0, 0, 0]
var last = 0

proc half_slice(l: seq[int], d: int, half: bool): seq[int] =
  let ender = len(l) - 1
  if not half: 
      result = l[0..d]
  else: 
      let rd = d + 1
      result = l[rd..ender]

echo rows
echo cols

for line in s:
    for it, c in line:
        if it < 7:
            row_half = c == 'B'
            if(it == 0): 
                divider = ( floor( len(rows) / 2 ) - 1 ).toInt
                row_processed = half_slice(rows, divider, row_half)
            else: 
                divider = ( floor( len(row_processed) / 2 ) - 1 ).toInt
                row_processed = half_slice(row_processed, divider, row_half)
                
        else:
            col_half = c == 'R'
            if(it == 7): 
                divider = ( floor( len(cols) / 2 ) - 1 ).toInt
                col_processed = half_slice(cols, divider, col_half)
            else: 
                divider = ( floor( len(col_processed) / 2 ) - 1 ).toInt
                col_processed = half_slice(col_processed, divider, col_half)

    if len(row_processed) == 1 and len(col_processed) == 1 and row_processed[0] > 0 and row_processed[0] < 127:
       i = (row_processed[0] * 8) + col_processed[0]
       ids.add(i)
    else:
       echo "processing error?"
       echo line
       echo row_processed
       echo col_processed

sort(ids)
for id in ids:
    case last
    of 0:
      triple[0] = id
      last += 1
    else:
      triple[last] = id
      let prev = last - 1
      if triple[last] - triple[prev] == 2:
        last += 1
      else: last = 0

    if last == 2: break
    if last == 0:
       for it, t in triple:
           triple[it] = 0

echo "Place is ", ( triple[1] - 1 )

# vi: expandtab ts=2
