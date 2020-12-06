# --- Part Two ---
# While it appears you validated the passwords correctly, they don't seem to be what the Official Toboggan Corporate Authentication System is expecting.
# 
# The shopkeeper suddenly realizes that he just accidentally explained the password policy rules from his old job at the sled rental place down the street! The Official Toboggan Corporate Policy actually works a little differently.
# 
# Each policy actually describes two positions in the password, where 1 means the first character, 2 means the second character, and so on. (Be careful; Toboggan Corporate Policies have no concept of "index zero"!) Exactly one of these positions must contain the given letter. Other occurrences of the letter are irrelevant for the purposes of policy enforcement.
# 
# Given the same example list from above:
# 
# 1-3 a: abcde is valid: position 1 contains a and position 3 does not.
# 1-3 b: cdefg is invalid: neither position 1 nor position 3 contains b.
# 2-9 c: ccccccccc is invalid: both position 2 and position 9 contain c.
# How many passwords are valid according to the new interpretation of the policies?

import strutils
import streams

var file_input = newFileStream("puzzle/puzzle2.txt", fmRead)
var s = ""
var first = 0
var last = 0
var limit_password: seq[string]
var limit_part: seq[string]
var limit: seq[string]
var needle = ""
var password = ""
var valid = 0
var part = 0


while not isNil(file_input):
  if file_input.readLine(s) and s != "":
#      echo s
      part = 0
      limit_password = s.split(": ")
      for it, piece in limit_password:
          if it == 0: limit_part = piece.split(" ")
          elif it == 1: password = piece
          else: password = password & ": " & piece

      for it, piece in limit_part:
          if it == 0:
              limit = piece.split("-")
              first = parseInt(limit[0])
              first -= 1
              last = parseInt(limit[1])
              last -= 1
          else: needle = piece

      for it, c in password:
          let sc = $c
          if it == first and sc == needle: part += 1
          elif it == last and sc == needle: part += 1
      # password_map = password.split('')
      if part == 1: valid += 1

#      echo "parsed ", first, "-", last, " ", needle, ": ", password
  else: break

echo "valid passwords: ", valid
file_input.close()
# vi: expandtab ts=2
