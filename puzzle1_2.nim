# --- Part Two ---
# The Elves in accounting are thankful for your help; one of them even offers you a starfish coin they had left over from a past vacation. They offer you a second one if you can find three numbers in your expense report that meet the same criteria.
# 
# Using the above example again, the three entries that sum to 2020 are 979, 366, and 675. Multiplying them together produces the answer, 241861950.
# 
# In your expense report, what is the product of the three entries that sum to 2020?

import sequtils
import strutils
import streams
import lists

var file_input = newFileStream("puzzle/puzzle1.txt", fmRead)
var s = ""
var n = 0
var i = 0
var arch = initSinglyLinkedList[int]()
var found = false
var sub = 0
var multiplied = 0
var sequence: seq[int]


while not isNil(file_input):
  if file_input.readLine(s):
      n = parseInt(s)
      echo "parsed ", n, "\n"
      if n > 0 and n < 2020:
          if i > 0:
              sub = 2020 - n
              sequence = toSeq(1..sub)
              keepIf(sequence, proc(subel: int): bool = arch.contains(subel) and arch.contains(2020 - (n+subel)))
              for si in sequence:
                  found = true
                  let third = 2020 - ( n + si )
                  multiplied = n * si * third
                  echo "found! ", n, " ", si, " ", third, "\n"

              if found: break

          arch.append(n)
          i += 1

if not found: echo "not found\n"
else: echo multiplied, "\n"

file_input.close()
# vi: expandtab ts=2
