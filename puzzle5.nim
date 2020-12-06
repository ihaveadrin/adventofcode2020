# https://adventofcode.com/2020/day/5
# --- Day 5: Binary Boarding ---
# You board your plane only to discover a new problem: you dropped your boarding pass! You aren't sure which seat is yours, and all of the flight attendants are busy with the flood of people that suddenly made it through passport control.
# 
# You write a quick program to use your phone's camera to scan all of the nearby boarding passes (your puzzle input); perhaps you can find your seat through process of elimination.
# 
# Instead of zones or groups, this airline uses binary space partitioning to seat people. A seat might be specified like FBFBBFFRLR, where F means "front", B means "back", L means "left", and R means "right".
# 
# The first 7 characters will either be F or B; these specify exactly one of the 128 rows on the plane (numbered 0 through 127). Each letter tells you which half of a region the given seat is in. Start with the whole list of rows; the first letter indicates whether the seat is in the front (0 through 63) or the back (64 through 127). The next letter indicates which half of that region the seat is in, and so on until you're left with exactly one row.
# 
# For example, consider just the first seven characters of FBFBBFFRLR:
# 
# Start by considering the whole range, rows 0 through 127.
# F means to take the lower half, keeping rows 0 through 63.
# B means to take the upper half, keeping rows 32 through 63.
# F means to take the lower half, keeping rows 32 through 47.
# B means to take the upper half, keeping rows 40 through 47.
# B keeps rows 44 through 47.
# F keeps rows 44 through 45.
# The final F keeps the lower of the two, row 44.
# The last three characters will be either L or R; these specify exactly one of the 8 columns of seats on the plane (numbered 0 through 7). The same process as above proceeds again, this time with only three steps. L means to keep the lower half, while R means to keep the upper half.
# 
# For example, consider just the last 3 characters of FBFBBFFRLR:
# 
# Start by considering the whole range, columns 0 through 7.
# R means to take the upper half, keeping columns 4 through 7.
# L means to take the lower half, keeping columns 4 through 5.
# The final R keeps the upper of the two, column 5.
# So, decoding FBFBBFFRLR reveals that it is the seat at row 44, column 5.
# 
# Every seat also has a unique seat ID: multiply the row by 8, then add the column. In this example, the seat has ID 44 * 8 + 5 = 357.
# 
# Here are some other boarding passes:
# 
# BFFFBBFRRR: row 70, column 7, seat ID 567.
# FFFBBBFRRR: row 14, column 7, seat ID 119.
# BBFFBBFRLL: row 102, column 4, seat ID 820.
# As a sanity check, look through your list of boarding passes. What is the highest seat ID on a boarding pass?
import strutils, sequtils, math

var s = readFile("puzzle/puzzle5.txt").strip().splitLines()
var i = 0
var divider: int
var max = 0
var rows = toSeq(0..127)
var cols = toSeq(0..7)
var row_processed: seq[int]
var col_processed: seq[int]
# halves are denoted by false on the lower half and true on the upper half
var row_half = false
var col_half = false

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

    if len(row_processed) == 1 and len(col_processed) == 1:
       i = (row_processed[0] * 8) + col_processed[0]
       if max < i: 
           max = i
    else:
       echo "processing error?"
       echo line
       echo row_processed
       echo col_processed

echo "highest seat ID ", max

# vi: expandtab ts=2
