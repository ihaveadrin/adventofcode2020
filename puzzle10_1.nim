# https://adventofcode.com/2020/day/10
# --- Part Two ---
# To completely determine whether you have enough adapters, you'll need to figure out how many different ways they can be arranged. Every arrangement needs to connect the charging outlet to your device. The previous rules about when adapters can successfully connect still apply.
# 
# The first example above (the one that starts with 16, 10, 15) supports the following arrangements:
# 
# (0), 1, 4, 5, 6, 7, 10, 11, 12, 15, 16, 19, (22)
# (0), 1, 4, 5, 6, 7, 10, 12, 15, 16, 19, (22)
# (0), 1, 4, 5, 7, 10, 11, 12, 15, 16, 19, (22)
# (0), 1, 4, 5, 7, 10, 12, 15, 16, 19, (22)
# (0), 1, 4, 6, 7, 10, 11, 12, 15, 16, 19, (22)
# (0), 1, 4, 6, 7, 10, 12, 15, 16, 19, (22)
# (0), 1, 4, 7, 10, 11, 12, 15, 16, 19, (22)
# (0), 1, 4, 7, 10, 12, 15, 16, 19, (22)
# (The charging outlet and your device's built-in adapter are shown in parentheses.) Given the adapters from the first example, the total number of arrangements that connect the charging outlet to your device is 8.
# 
# The second example above (the one that starts with 28, 33, 18) has many arrangements. Here are a few:
# 
# (0), 1, 2, 3, 4, 7, 8, 9, 10, 11, 14, 17, 18, 19, 20, 23, 24, 25, 28, 31,
# 32, 33, 34, 35, 38, 39, 42, 45, 46, 47, 48, 49, (52)
# 
# (0), 1, 2, 3, 4, 7, 8, 9, 10, 11, 14, 17, 18, 19, 20, 23, 24, 25, 28, 31,
# 32, 33, 34, 35, 38, 39, 42, 45, 46, 47, 49, (52)
# 
# (0), 1, 2, 3, 4, 7, 8, 9, 10, 11, 14, 17, 18, 19, 20, 23, 24, 25, 28, 31,
# 32, 33, 34, 35, 38, 39, 42, 45, 46, 48, 49, (52)
# 
# (0), 1, 2, 3, 4, 7, 8, 9, 10, 11, 14, 17, 18, 19, 20, 23, 24, 25, 28, 31,
# 32, 33, 34, 35, 38, 39, 42, 45, 46, 49, (52)
# 
# (0), 1, 2, 3, 4, 7, 8, 9, 10, 11, 14, 17, 18, 19, 20, 23, 24, 25, 28, 31,
# 32, 33, 34, 35, 38, 39, 42, 45, 47, 48, 49, (52)
# 
# (0), 3, 4, 7, 10, 11, 14, 17, 20, 23, 25, 28, 31, 34, 35, 38, 39, 42, 45,
# 46, 48, 49, (52)
# 
# (0), 3, 4, 7, 10, 11, 14, 17, 20, 23, 25, 28, 31, 34, 35, 38, 39, 42, 45,
# 46, 49, (52)
# 
# (0), 3, 4, 7, 10, 11, 14, 17, 20, 23, 25, 28, 31, 34, 35, 38, 39, 42, 45,
# 47, 48, 49, (52)
# 
# (0), 3, 4, 7, 10, 11, 14, 17, 20, 23, 25, 28, 31, 34, 35, 38, 39, 42, 45,
# 47, 49, (52)
# 
# (0), 3, 4, 7, 10, 11, 14, 17, 20, 23, 25, 28, 31, 34, 35, 38, 39, 42, 45,
# 48, 49, (52)
# In total, this set of adapters can connect the charging outlet to your device in 19208 distinct arrangements.
# 
# You glance back down at your bag and try to remember why you brought so many adapters; there must be more than a trillion valid ways to arrange them! Surely, there must be an efficient way to count the arrangements.
# 
# What is the total number of distinct ways you can arrange the adapters to connect the charging outlet to your device?
import strutils
import sequtils
import tables
import algorithm, math

type Distrib = seq[int]
var s = readFile("puzzle/puzzle10.txt").strip().splitLines()
var list: seq[int]
var diffs = initTable[int, Distrib]()
var count_path = 0

proc pathfinder(current_position: int, dest: int): int =
    result = 0
    if current_position == dest: result = 1
    else:
        let cur = list[current_position]
        let stopAt = cur + 3
        var i = current_position + 1
        result += pathfinder(i, dest)
        i += 1
        while i < dest and list[i] <= stopAt:
            result += pathfinder(i, dest)
            i += 1

list.add(0)

for line in s:
    list.add(parseInt(line))

sort(list)
for i, n in list:
    if i == 0:
        diffs[n] = @[0]
    else:
        let prev = i - 1
        let diff = n - list[prev]
        if not diffs.hasKey(diff):
            diffs[diff] = @[i]
        else: diffs[diff].add(i)

let d_last = len(list) - 1
list.add(list[d_last] + 3)
diffs[3].add(d_last + 1)

for it, d in diffs[3]:
    if it == 0:
        count_path = pathfinder(0, d)
    else:
        let prev = it - 1
        count_path = count_path * pathfinder(diffs[3][prev], d)

echo "All possible paths: ", count_path


# vi: expandtab ts=4
