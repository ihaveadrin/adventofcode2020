# https://adventofcode.com/2020/day/1
# --- Day 1: Report Repair ---
# After saving Christmas five years in a row, you've decided to take a vacation at a nice resort on a tropical island. Surely, Christmas will go on without you.
# 
# The tropical island has its own currency and is entirely cash-only. The gold coins used there have a little picture of a starfish; the locals just call them stars. None of the currency exchanges seem to have heard of them, but somehow, you'll need to find fifty of these coins by the time you arrive so you can pay the deposit on your room.
# 
# To save your vacation, you need to get all fifty stars by December 25th.
# 
# Collect stars by solving puzzles. Two puzzles will be made available on each day in the Advent calendar; the second puzzle is unlocked when you complete the first. Each puzzle grants one star. Good luck!
# 
# Before you leave, the Elves in accounting just need you to fix your expense report (your puzzle input); apparently, something isn't quite adding up.
# 
# Specifically, they need you to find the two entries that sum to 2020 and then multiply those two numbers together.
# 
# For example, suppose your expense report contained the following:
# 
# 1721
# 979
# 366
# 299
# 675
# 1456
# In this list, the two entries that sum to 2020 are 1721 and 299. Multiplying them together produces 1721 * 299 = 514579, so the correct answer is 514579.
# 
# Of course, your expense report is much larger. Find the two entries that sum to 2020; what do you get if you multiply them together?

import strutils
import streams
import lists

var file_input = newFileStream("puzzle/puzzle1.txt", fmRead)
var s = ""
var n = 0
var i = 0
var arch = initSinglyLinkedList[int]()
var found = false
var sum = 0
var sub = 0
var multiplied = 0


while not isNil(file_input):
  if file_input.readLine(s):
      n = parseInt(s)
      echo "parsed ", n, "\n"
      if n > 0 and n < 2020:
          if i > 0:
              sub = 2020 - n
              if arch.contains(sub):
                  found = true
                  multiplied = n * sub
                  echo "found! ", sub, " ", multiplied, "\n"

              if found: break

          arch.append(n)
          i += 1

if not found: echo "not found\n"
else: echo multiplied, "\n"

file_input.close()
# vi: expandtab ts=2
