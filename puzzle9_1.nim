# https://adventofcode.com/2020/day/9
# --- Part Two ---
# The final step in breaking the XMAS encryption relies on the invalid number you just found: you must find a contiguous set of at least two numbers in your list which sum to the invalid number from step 1.
# 
# Again consider the above example:
# 
# 35
# 20
# 15
# 25
# 47
# 40
# 62
# 55
# 65
# 95
# 102
# 117
# 150
# 182
# 127
# 219
# 299
# 277
# 309
# 576
# In this list, adding up all of the numbers from 15 through 40 produces the invalid number from step 1, 127. (Of course, the contiguous set of numbers in your actual list might be much longer.)
# 
# To find the encryption weakness, add together the smallest and largest number in this contiguous range; in this example, these are 15 and 47, producing 62.
# 
# What is the encryption weakness in your XMAS-encrypted list of numbers?
import strutils
import algorithm
import math

var s = readFile("puzzle/puzzle9.txt").strip().splitLines()
var full_list: seq[int]
var remainder: seq[int]
var tmp = 0
var found = false
var interr = false
var min_corrupt = 0
var max_corrupt = 0
var min = 0
var max = 1
var summer = 0
let corrupt = 507622668


for line in s:
    tmp = parseInt(line)
    full_list.add(tmp)

let ender = len(full_list)
while not (interr or found):
    summer = 0
    while max < ender and summer < corrupt:
        remainder = full_list[min..max]
        let lst = len(remainder) - 1
        if summer == 0: 
            summer = sum(remainder)
        else:
            summer += remainder[lst]
        max += 1

    if max < ender:
        if summer == corrupt:
            found = true
            sort(remainder)
            echo remainder
            echo summer, " == ", corrupt
            min_corrupt = remainder[0]
            let lst = len(remainder) - 1
            max_corrupt = remainder[lst]
        else:
            min += 1
            max = min + 1

    if min == (ender - 1): interr = true


if found:
    echo min_corrupt
    echo max_corrupt
    echo (min_corrupt + max_corrupt)
else:
    echo "number not found?"
    echo full_list

# vi: expandtab ts=4
