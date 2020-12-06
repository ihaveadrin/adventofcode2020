# see puzzle3.nim
# https://adventofcode.com/2020/day/3#part2
# --- Part Two ---
# Time to check the rest of the slopes - you need to minimize the probability of a sudden arboreal stop, after all.
# 
# Determine the number of trees you would encounter if, for each of the following slopes, you start at the top-left corner and traverse the map all the way to the bottom:
# 
# Right 1, down 1.
# Right 3, down 1. (This is the slope you already checked.)
# Right 5, down 1.
# Right 7, down 1.
# Right 1, down 2.
# In the above example, these slopes would find 2, 7, 3, 4, and 2 tree(s) respectively; multiplied together, these produce the answer 336.
#
# What do you get if you multiply together the number of trees encountered on each of the listed slopes?
import streams

var file_input = newFileStream("puzzle/puzzle3.txt", fmRead)
var s = ""
var i = 0
var tree = '#';
var multiplier = 1
var positions = @[
# remainder | shift position to right | current position | trees encountered
                  @[1, 1, 0, 0],
                  @[1, 3, 0, 0],
                  @[1, 5, 0, 0],
                  @[1, 7, 0, 0],
                  @[2, 1, 0, 0],
                ]


while not isNil(file_input):
  if file_input.readLine(s) and s != "":
    let ls = len(s)
    if i > 0:
        for it, pos in positions:
            let curpos = positions[it][2]

            if curpos >= ls: positions[it][2] = curpos - ls

        for it, c in s:
            for sit, pos in positions:
                if i %% pos[0] == 0 and it == pos[2] and c == tree: positions[sit][3] += 1

    i += 1
    for it, pos in positions:
        if i %% positions[it][0] == 0: positions[it][2] += positions[it][1]
  else: break


for it, pos in positions:
    echo "trees encountered: ", pos[3]
    multiplier *= pos[3]

echo "\ntotal: ", multiplier

file_input.close()
# vi: expandtab ts=2
