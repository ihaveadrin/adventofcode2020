# --- Day 2: Password Philosophy ---
# Your flight departs in a few days from the coastal airport; the easiest way down to the coast from here is via toboggan.
# 
# The shopkeeper at the North Pole Toboggan Rental Shop is having a bad day. "Something's wrong with our computers; we can't log in!" You ask if you can take a look.
# 
# Their password database seems to be a little corrupted: some of the passwords wouldn't have been allowed by the Official Toboggan Corporate Policy that was in effect when they were chosen.
# 
# To try to debug the problem, they have created a list (your puzzle input) of passwords (according to the corrupted database) and the corporate policy when that password was set.
# 
# For example, suppose you have the following list:
# 
# 1-3 a: abcde
# 1-3 b: cdefg
# 2-9 c: ccccccccc
# Each line gives the password policy and then the password. The password policy indicates the lowest and highest number of times a given letter must appear for the password to be valid. For example, 1-3 a means that the password must contain a at least 1 time and at most 3 times.
# 
# In the above example, 2 passwords are valid. The middle password, cdefg, is not; it contains no instances of b, but needs at least 1. The first and third passwords are valid: they contain one a or nine c, both within the limits of their respective policies.
# 
# How many passwords are valid according to their policies?

import strutils
import streams

var file_input = newFileStream("puzzle/puzzle2.txt", fmRead)
var s = ""
var min = 0
var max = 0
var limit_password: seq[string]
var limit_part: seq[string]
var limit: seq[string]
var needle = ""
var password = ""
var valid = 0


while not isNil(file_input):
  if file_input.readLine(s) and s != "":
#      echo s
      limit_password = s.split(": ")
      for it, piece in limit_password:
          if it == 0: limit_part = piece.split(" ")
          elif it == 1: password = piece
          else: password = password & ": " & piece

      for it, piece in limit_part:
          if it == 0:
              limit = piece.split("-")
              min = parseInt(limit[0])
              max = parseInt(limit[1])
          else: needle = piece

      let co = count(password, needle)
      if co >= min and co <= max: valid += 1

#      echo "parsed ", min, "-", max, " ", needle, ": ", password
  else: break

echo "valid passwords: ", valid
file_input.close()
# vi: expandtab ts=2
