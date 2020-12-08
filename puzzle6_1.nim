# https://adventofcode.com/2020/day/6
# --- Part Two ---
# As you finish the last group's customs declaration, you notice that you misread one word in the instructions:
# 
# You don't need to identify the questions to which anyone answered "yes"; you need to identify the questions to which everyone answered "yes"!
# 
# Using the same example as above:
# 
# abc
# 
# a
# b
# c
# 
# ab
# ac
# 
# a
# a
# a
# a
# 
# b
# This list represents answers from five groups:
# 
# In the first group, everyone (all 1 person) answered "yes" to 3 questions: a, b, and c.
# In the second group, there is no question to which everyone answered "yes".
# In the third group, everyone answered yes to only 1 question, a. Since some people did not answer "yes" to b or c, they don't count.
# In the fourth group, everyone answered yes to only 1 question, a.
# In the fifth group, everyone (all 1 person) answered "yes" to 1 question, b.
# In this example, the sum of these counts is 3 + 0 + 1 + 1 + 1 = 6.
# 
# For each group, count the number of questions to which everyone answered "yes". What is the sum of those counts?

import strutils

type Bullet = array[26, int]
var s = readFile("puzzle/puzzle6.txt").strip().splitLines()
var i = 0
var sum = 0
let alphabet = "abcdefghijklmnopqrstuvwxyz"
var group_answers: seq[string]
var group_members: seq[int]
var group_answers_count: seq[Bullet]

proc load_bullet(): Bullet = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

group_answers.add("")
group_members.add(0)
group_answers_count.add(load_bullet())

for line in s:
    if line == "":
        group_answers.add("")
        group_members.add(0)
        group_answers_count.add(load_bullet())
        i += 1
    else:
        group_members[i] += 1
        for c in line:
            let idx = find(alphabet, c)
            group_answers_count[i][idx] += 1
            group_answers[i] = group_answers[i] & $c

for it, group in group_members:
    for lit, letter in group_answers_count[it]:
        if letter == group: sum += 1

echo "Totale: ", sum

# vi: expandtab ts=2
